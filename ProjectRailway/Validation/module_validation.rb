module Validation
  @validate_macros = {}

  def self.validate_macros
    @validate_macros
  end

  def self.included(base)
    base.extend ClassMethods
    base.send(:include, InstanceMethods)
  end

  module ClassMethods
    def validate(name, *args)
      if Validation.validate_macros.has_key?(name)
        args.each { |ind| Validation.validate_macros[name] << ind }
      else
        Validation.validate_macros[name] = args
      end
    end
  end

  module InstanceMethods
    def validate!
      Validation.validate_macros.each do |key, val|
        val.each_index do |i|
          case val[i]
          when :presence 
            raise RuntimeError, 'Value is nil' unless instance_variable_get("@#{key}")
            true
          when :type
            raise RuntimeError, 'Type mismatch' unless instance_variable_get("@#{key}").is_a? val[i+1]
            true
          when :format
            raise RuntimeError, 'Wrong format' unless instance_variable_get("@#{key}") =~ val[i+1]
            true
          end
        end
      end
    end

    def valid?
      self.validate!
      rescue RuntimeError
      false
    end
  end
end

# class Test
#   include Validation
#   attr_accessor :name, :number
#   validate :name, :presence
#   validate :number, :type, String
#   validate :number, :format, /[0-9]+/
#   def initialize
#     @name = 'Wow'
#     @number = '1999'
#   end
# end