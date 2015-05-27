require_relative '02_searchable'
require 'active_support/inflector'

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    @class_name.constantize
  end

  def table_name
    model_class.table_name
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})

    if options[:foreign_key]
      self.foreign_key = "#{options[:foreign_key].to_s.singularize.underscore.downcase}".to_sym
    else
      self.foreign_key = "#{name.to_s.singularize.underscore.downcase}_id".to_sym
    end

    if options[:class_name]
      self.class_name = options[:class_name]
    else
      self.class_name = name.to_s.capitalize.singularize.camelcase
    end

    if options[:primary_key]
      self.primary_key = options[:primary_key]
    else
      self.primary_key = :id
    end
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    if options[:primary_key]
      self.primary_key = options[:primary_key]
    else
      self.primary_key = :id
    end

    if options[:foreign_key]
      self.foreign_key = options[:foreign_key]
    else
      self.foreign_key = "#{self_class_name.downcase}_id".to_sym
    end

    if options[:class_name]
      self.class_name = options[:class_name]
    else
      self.class_name = name.to_s.capitalize.singularize
    end
  end
end

module Associatable
  # Phase IIIb
  def belongs_to(name, options = {})
    # Builds belongstooptions object, saved in a local options variable
    new_options = BelongsToOptions.new(name, options)

    # here we are creating a new method for objects of the class to
    # access the association
    # what does access the association actually mean?
    # looks like were gonna use where to access the table.
    #
    # access the table of what foreign_key is pointing to
    # choose all rows that have the same value as foreign_key
    # where('table_name.id = new_options.foreign_key')
    # need the class



    define_method(name) do
      # this gives us the human's id
      foreign_id = self.send(new_options.foreign_key)

      # human.where is accessing our class table
      #
      # Human.where ({id: foreign_id})
      our_class = new_options.model_class

      # now we've got our class, accessing rows with
      # an id equivalent to what were pointing to.
      # i.e. grabbing our connected object
      our_class.where({id: foreign_id}).first

    end
  end

  def has_many(name, options = {})
    new_options = HasManyOptions.new(name, self.to_s, options)

    define_method(name) do
      my_id = self.id
      has_many_class = new_options.model_class

      has_many_class.where({new_options.foreign_key => my_id})
    end
  end

  def assoc_options
    # Wait to implement this in Phase IVa. Modify `belongs_to`, too.
  end
end

class SQLObject
  extend Associatable
end
