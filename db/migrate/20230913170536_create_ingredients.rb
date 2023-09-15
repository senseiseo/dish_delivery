class CreateIngredients < ActiveRecord::Migration[7.0]
  def change
    create_table :ingredients do |t|
      t.string :name, null: false
      t.boolean :included, default: true, null: false
      
      t.timestamps
    end
  end
end
