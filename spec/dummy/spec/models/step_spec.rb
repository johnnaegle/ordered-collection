require 'spec_helper'

describe Step do
  subject {Step.new}
  
  it {should belong_to(:recipe)}
  it {should validate_numericality_of(:step_number).only_integer }
  it {should allow_value(1, 10).for(:step_number)}
  it {should_not allow_value(0, -1, -2, -10).for(:step_number)}

  it {should validate_presence_of(:instruction)}

  it {should_not allow_mass_assignment_of(:recipe)}
  it {should_not allow_mass_assignment_of(:recipe_id)}
  it {should allow_mass_assignment_of(:instruction)}
  it {should allow_mass_assignment_of(:step_number)}
end
