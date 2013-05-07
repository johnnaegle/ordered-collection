class Ingredient < ActiveRecord::Base
  attr_accessible :display_order, :name
  
  belongs_to :recipe, :inverse_of => :ingredients
  
  validates :name, :presence => true
  validates :display_order, :numericality => {:greater_than_or_equal_to => 0, :only_integer => true}
end
