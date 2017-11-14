module Validation

  def self.included(base)
    base.extend ClassMethods
    base.send(:include, InstanceMethods)
  end

  module ClassMethods
    attr_accessor :validate_macros

    def validate(name, *args)
      @validate_macros ||= Hash.new { |hash, key| hash[key] = [] }
      args.each { |value| @validate_macros[name] << value }
    end
  end

  module InstanceMethods

    def validate_presence
      self.class.validate_macros.each do |key,value| 
        if value[0] == :presence
          raise RuntimeError, 'Value is nil' unless instance_variable_get("@#{key}")
        end
      end
    end

    def validate_type
      self.class.validate_macros.each do |key,value|
        if value[0] == :type
          raise RuntimeError, 'Type mismatch' unless instance_variable_get("@#{key}").is_a? value[1]
        end
      end
    end

    def validate_format
      self.class.validate_macros.each do |key,value|
        if value[0] == :format
          raise RuntimeError, 'Wrong format' unless instance_variable_get("@#{key}") =~ value[1]
        end
      end
    end

    def validate!
      self.class.validate_macros.each { |i,j| self.send("validate_#{j[0]}".to_sym) }
      return true
    end

    def valid?
      validate!
      rescue RuntimeError
      false
    end
  end
end
