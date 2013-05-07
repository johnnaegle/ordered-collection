# ordered-collection
## Install

    gem install ordered-collection

and in your Gemfile:
    
    gem 'ordered-collection'

Model declaration:

    class Something < ActiveRecord::Base
      belongs_to :cool_class
      attr_accessible :display_order
    end
    
    class CoolClass < ActiveRecord::Base
      has_many :somethings
      has_ordered_collection :somethings
    end    

## About

A simple rails gem that allows ActiveRecord models to persist a has_many association with an
order column that is maintained starting at zero and without gaps.

## Example

    class Ingredient < ActiveRecord::Base
      attr_accessible :display_order, :name
      belongs_to :recipe, :inverse_of => :ingredients
      validates :display_order, :numericality => {:greater_than_or_equal_to => 0, :only_integer => true}
    end

    class Recipe < ActiveRecord::Base
      has_many :ingredients, :inverse_of => :recipe, :dependent => :destroy
      accepts_nested_attributes_for :ingredients, :allow_destroy => true

      has_ordered_collection :ingredients
    end

    recipe = Recipe.new()
    recipe.ingredients.build(:display_order => 20, :name => 'two')
    recipe.ingredients.build(:display_order => 0, :name => 'zero')
    recipe.ingredients.build(:display_order => 10, :name => 'one')
    i = recipe.ingredients.build(:display_order => 15, :name => 'three')
    i.mark_for_destruction
    
    puts recipe.ingredients.map(&:name).join(',')
    # two,zero,one,three
        
    puts recipe.ordered_ingredients.map(&:name).join(',')
    # zero,one,two

    puts recipe.ordered_ingredients.map(&:display_order).join(',')
    # 0,10,20
    
    recipe.save!

    puts recipe.ordered_ingredients.map(&:name).join(',')
    # zero,one,two

    puts recipe.ordered_ingredients.map(&:display_order).join(',')
    # 0,1,2
    
    recipe.ingredients.order(:display_order).map(&:display_order)
    #  Ingredient Load (0.3ms)  SELECT "ingredients".* FROM "ingredients" WHERE "ingredients"."recipe_id" = 1 ORDER BY display_order
    # [0, 1, 2]
    
# Additional notes

You can select a different order column
  class Recipe < ActiveRecord::Base
    has_many :steps, :inverse_of => :recipe, :dependent => :destroy
    has_ordered_collection :steps, :sort_field => :step_number
  end


## Copyright

Copyright (c) 2013 John Naegle. See LICENSE for details.
