require 'spec_helper'

describe Recipe do
  it { should have_many(:ingredients) }
  it { should accept_nested_attributes_for(:ingredients).allow_destroy(true) }

  it { should have_many(:steps) }
  it { should accept_nested_attributes_for(:steps).allow_destroy(true) }
  
  it { should be_respond_to(:ordered_ingredients)}
  it { should be_respond_to(:ordered_steps)}
  
  let(:recipe) {Recipe.new}
  let(:recipe_with_ingredients) {
    recipe.ingredients.build(:display_order => 0, :name => 'zero')
    recipe.ingredients.build(:display_order => 1, :name => 'one')
    recipe.ingredients.build(:display_order => 2, :name => 'two')
    recipe.ingredients.shuffle!
    recipe
  }
  
  let(:recipe_with_steps) {
    recipe.steps.build(:step_number => 1, :instruction => 'one')
    recipe.steps.build(:step_number => 2, :instruction => 'two')
    recipe.steps.build(:step_number => 3, :instruction => 'three')
    recipe.steps.shuffle!
    recipe  
  }
  
  context "collection with default sort field" do
    it "is set if missing" do
      r = recipe_with_ingredients
      r.ingredients.detect{|i| i.name == 'one'}.display_order = ''
      
      r.should be_valid
    end
    
    it "omits a deleted member" do
      r = recipe_with_ingredients
      r.ingredients.detect{|i| i.name == 'one'}.mark_for_destruction
      
      r.ordered_ingredients.map(&:name).should == ['zero', 'two']
    end
    
    it "sorts correctly" do
      10.times do 
        recipe_with_ingredients.ingredients.shuffle!
        recipe_with_ingredients.ordered_ingredients.map(&:name).should == ['zero', 'one', 'two']
      end
    end
  end
  
  context "collection with alternative sort field" do 
    it "is set if missing" do
      r = recipe_with_steps
      r.steps[1].step_number = ''

      r.should be_valid
      r.steps.map(&:step_number).should =~ [1,2,3]
    end
    
    it "sorts correctly" do
      10.times do 
        recipe_with_steps.steps.shuffle!
        recipe_with_steps.ordered_steps.map(&:instruction).should == ['one', 'two', 'three']
      end
    end
  end
  
  
end
