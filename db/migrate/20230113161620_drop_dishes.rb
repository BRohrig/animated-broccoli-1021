class DropDishes < ActiveRecord::Migration[5.2]
  def change
    drop_table :dish_ingredients
    drop_table :dishes
    drop_table :ingredients
    drop_table :chefs
    
    
    
  end
end
