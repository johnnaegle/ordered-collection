class Recipe < ActiveRecord::Base

  has_many :ingredients, :inverse_of => :recipe, :dependent => :destroy
  accepts_nested_attributes_for :ingredients, :allow_destroy => true

  has_many :steps, :inverse_of => :recipe, :dependent => :destroy
  accepts_nested_attributes_for :steps, :allow_destroy => true
  
  validates_associated :ingredients, :steps
  
  has_ordered_collection :ingredients
  has_ordered_collection :steps, :sort_field => :step_number
  
end
