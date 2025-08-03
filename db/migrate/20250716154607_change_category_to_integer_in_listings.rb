class ChangeCategoryToIntegerInListings < ActiveRecord::Migration[8.0]
  def change
    # First, cast string to integer if needed, or drop and re-add safely
    remove_column :listings, :category
    add_column :listings, :category, :integer
  end
end
