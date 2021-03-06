module DataMapper
  module Validate

    class AcceptanceValidator < GenericValidator

      def self.default_message_for_field(field_name)
        '%s is not accepted'.t(DataMapper::Inflection.humanize(field_name))
      end
      
      def initialize(field_name, options = {})
        super
        @options = options
        @field_name = field_name
        @options[:allow_nil] = true unless @options.include?(:allow_nil)
        @options[:accept] ||= "1"
        @options[:accept] = Array(@options[:accept])
      end
      
      def call(target)
        unless valid?(target)
          error_message = @options[:message] || DataMapper::Validate::AcceptanceValidator.default_message_for_field(@field_name)
          add_error(target, error_message , @field_name)
          return false
        end
        
        return true
      end
      
      def valid?(target)
        field_value = target.instance_variable_get("@#{@field_name}")
        return true if @options[:allow_nil] && field_value.nil?
        return false if !@options[:allow_nil] && field_value.nil?

        @options[:accept].include?(field_value)
      end
            
    end

    
    module ValidatesAcceptanceOf
      def self.included(base)
        base.extend(ClassMethods)
      end
      
      module ClassMethods
        
        def validates_acceptance_of(*fields)
          opts = opts_from_validator_args(fields)
          add_validator_to_context(opts, fields, DataMapper::Validate::AcceptanceValidator)
        end
      end
      
    end
    
    
    
        
  end  
end
