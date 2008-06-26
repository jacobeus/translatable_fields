# TranslatableFields

module ActiveRecord
  module TranslatableFields #:nodoc:
    
    @@languages = [] # To be overriden in environment.rb
    @@default_language = :en
    @@current_language = nil

    def self.included(base) # :nodoc:
      base.extend(ClassMethods)
    end
    
    def self.languages=(languages)
      @@languages = languages
    end
    
    def self.current_language=(language)
      @@current_language = language
    end
    
    def self.current_language
      @@current_language || @@default_language
    end
    
    module ClassMethods # ==============================================================================

      def translatable_fields(*fields)
        @@translatable_fields = fields
        @current_language = nil
        
        @@translatable_fields.each do |f|
          self.class_eval <<-END_OF_METHOD
            def #{f}
              value=self.send("#{f}_"+ActiveRecord::TranslatableFields.current_language.to_s)
              value.blank? ? "__localization_missing__" : value
            end
          END_OF_METHOD
        end
        self.class_eval <<-END_OF_METHOD
          def translated_fields
            #{fields.inspect}
          end
        END_OF_METHOD
      end
    
    end#ClassMethods
    
    module SingletonMethods # ==========================================================================
      
    end#SingletonMethods

    
    module InstanceMethods # ===========================================================================
    end#InstanceMethods

  end#TranslatableFields
end#ActiveRecord