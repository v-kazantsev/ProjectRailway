module Accessors

  def self.included(base)
    base.extend ClassMethods
    base.send(:include, InstanceMethods)
  end

  module ClassMethods
    attr_reader :attr_history
    def attr_accessor_with_history(*args)
      @attr_history = {}
      args.each do |name|
        @attr_history[name.to_s + '_history'] ||= []
        define_method(name) { instance_variable_get("@#{name}".to_sym) }
        define_method("#{name}=".to_sym) do |val|
          instance_variable_set("@#{name}".to_sym, val)
          self.class.attr_history[name.to_s + '_history'] << val
        end
      end
    end

    def strong_attr_accessor(arg,klass)
      define_method(arg) { instance_variable_get("@#{arg}".to_sym) }
      define_method("#{arg}=") do |value|
        if value.is_a? klass
          instance_variable_set("@#{arg}".to_sym, value)
        else
          raise ArgumentError, "#{klass} expected"
        end
      end
    end

  end

  module InstanceMethods
    def method_missing(name)
      raise ArgumentError, 'Wrong method name' if name.to_s !~ /\A\w+(_history)\z/
      self.class.attr_history[name.to_s]
    end
  end
end

class Test
  include Accessors
  attr_accessor_with_history :a, :b, :abcd
  strong_attr_accessor :d, String
end
