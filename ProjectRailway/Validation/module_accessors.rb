module Accessors
  @vars_history = {}

  def self.vars_history
    @vars_history
  end

  def self.included(base)
    base.extend ClassMethods
    base.send(:include, InstanceMethods)
  end
  module ClassMethods
    def attr_accessor_with_history(*args)
      args.each do |name|
        define_method(name) { instance_variable_get("@#{name}".to_sym) }
        define_method("#{name}=".to_sym) do |val|
          instance_variable_set("@#{name}".to_sym, val)
          (Accessors.vars_history[name] ||= []) << val
        end
      end
    end

    def strong_attr_accessor(arg,klass)
      self.class_eval("def #{arg};@#{arg};end")
      self.class_eval("def #{arg}=(value)
                       if #{klass} == value.class
                         @#{arg}=value
                       else
                         raise ArgumentError, '#{klass} expected'
                       end
                       end")
    end
  end

  module InstanceMethods
    def method_missing(name)
      raise ArgumentError, 'Wrong method name' if name.to_s !~ /\A\w+(_history)\z/
      Accessors.vars_history[name.to_s.sub(/(_history)/, '').to_sym]
    end
  end
end

class Test
  include Accessors
  attr_accessor_with_history :a, :b, :abcd
  strong_attr_accessor :d, String
end
