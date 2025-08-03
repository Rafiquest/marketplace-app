class FixCategoryTypeInListings < ActiveRecord::Migration[7.1]
  def change
    remove_column :listings, :category
    add_column :listings, :category, :integer
  end
end
