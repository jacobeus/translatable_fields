# Include hook code here

require 'translatable_fields'
ActiveRecord::Base.send(:include, ActiveRecord::TranslatableFields)
require File.dirname(__FILE__) + '/lib/translatable_fields'