class AttrAccessorObject
  def self.my_attr_accessor(*names)
    names.each do |name|
      instance = ("@" + name.to_s).to_sym
      define_method(name) { instance_variable_get(instance) }

      getter = (name.to_s + '=').to_sym
      define_method(getter) { |arg| instance_variable_set(instance, arg)}
    end
  end
end
