module Validation

  def self.included(base)
    base.extend ClassMethods
    base.send(:include, InstanceMethods)
  end

  module ClassMethods
    attr_accessor :validations

    def validate(name, *args)
      @validations ||= Hash.new { |hash, key| hash[key] = [] }
      @validations[name]  << args 
    end
  end

  module InstanceMethods

    def valid?
      validate!
      rescue RuntimeError => e
        puts "#{e.message}"
      return false
    end

    private

    def validate_presence(var,param)
      raise RuntimeError, 'Value is nil' if instance_variable_get("@#{var}").nil?
    end

    def validate_type(var, param)
      raise RuntimeError, 'Type mismatch' unless instance_variable_get("@#{var}").is_a? param
    end

    def validate_format(var,param)
      raise RuntimeError, 'Wrong format' unless instance_variable_get("@#{var}") =~ param
    end

    def validate!
      self.class.validations.each do |key, value|
        value.each do |param|
          self.send("validate_#{param[0]}", key, param[-1]) 
        end
      end
      return true
    end
  end
end
# class Test
#   include Validation
#   attr_accessor :name, :price
#   validate :name, :presence
#   validate :name, :type, String
#   validate :name, :format, /\w+/
# end
