require 'spec_helper'

describe Ingredient do
  it {should belong_to(:recipe)}
  it {should validate_numericality_of(:display_order).only_integer }
  it {should allow_value(0, 1, 10).for(:display_order)}
  it {should_not allow_value(-1, -2, -10).for(:display_order)}

  it {should validate_presence_of(:name)}

  it {should_not allow_mass_assignment_of(:recipe)}
  it {should_not allow_mass_assignment_of(:recipe_id)}
  it {should allow_mass_assignment_of(:name)}
  it {should allow_mass_assignment_of(:display_order)}
end
