class CreateSteps < ActiveRecord::Migration
  def change
    create_table :steps do |t|
      t.string :instruction
      t.integer :recipe_id
      t.integer :step_number

      t.timestamps
    end
  end
end
