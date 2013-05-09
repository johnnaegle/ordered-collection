class Step < ActiveRecord::Base
  attr_accessible :instruction, :step_number
  
  belongs_to :recipe, :inverse_of => :ingredients
  
  validates :instruction, :presence => true
  validates :step_number, :numericality => {:greater_than_or_equal_to => 1, :only_integer => true}  
end
