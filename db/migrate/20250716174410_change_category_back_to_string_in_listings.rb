class ChangeCategoryBackToStringInListings < ActiveRecord::Migration[8.0]
  def change
    remove_column :listings, :category
    add_column :listings, :category, :string
  end
end
