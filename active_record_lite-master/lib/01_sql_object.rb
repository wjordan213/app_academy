require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    # returns an array with the names of the talbe's columns
    cols = []
    cols = DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        #{self.table_name}
    SQL

    return cols[0].map(&:to_sym)
  end

  def self.finalize!
    # called at the end of the subclass definition to add the getter and
    # setter methods

    columns.each do |col|
      instance = ("@" + col.to_s).to_sym
      define_method(col) { attributes[col] }

      setter_name = (col.to_s + '=').to_sym
      define_method(setter_name) do |arg|
        attributes[col] = arg
      end
    end
  end

  def self.table_name=(table_name)
    # sets the table name for the class
    # stores that name inside of a class instance variable
    @table_name = table_name
  end

  def self.table_name
    # gets the name of the table for the class
    @table_name.nil? ? self.to_s.tableize : @table_name
  end

  def self.all
    selves = DBConnection.execute(<<-SQL)
      SELECT
        #{table_name}.*
      FROM
        #{table_name}
    SQL

    parse_all(selves)
  end

  def self.parse_all(results)
    results.map{ |result| self.new(result)}
  end

  def self.find(id)
    result = DBConnection.execute(<<-SQL)
      SELECT
        #{table_name}.*
      FROM
        #{table_name}
      WHERE
        #{table_name}.id = #{id}
      LIMIT
        1
    SQL

    parse_all(result).first
  end

  def initialize(params = {})
    params.each do |name, value|
      name_sym = name.to_sym
      if self.class.columns.none? { |col| col == name_sym }
        raise "unknown attribute '#{name}'"
      else
        self.send((name.to_s + '='), value)
      end
    end


  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    x = self.class.columns.map { |col| self.send(col) }

  end

  def insert
    col_names = self.class.columns.join(', ')
    vals = attribute_values
    question_marks = (['?'] * vals.count).join(', ')

    DBConnection.execute(<<-SQL, *attribute_values)
      INSERT INTO
        #{self.class.table_name} (#{col_names})
      VALUES
        (#{question_marks})
    SQL

    self.id = DBConnection.last_insert_row_id
  end

  def update
    names = self.class.columns
    names.delete(:id)
    new_names = names.map { |name| name.to_s + ' = ?'}.join(', ')
    vals = attribute_values
    vals.delete(self.id)

    DBConnection.execute(<<-SQL, *vals, self.id)
    UPDATE
      #{self.class.table_name}
    SET
      #{new_names}
    WHERE
      id = ?
    SQL
  end

  def save
    if id.nil?
      insert
    else
      update
    end
  end
end
