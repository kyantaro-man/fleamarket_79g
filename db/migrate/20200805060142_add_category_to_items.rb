class AddCategoryToItems < ActiveRecord::Migration[6.0]
  def change
    remove_column :items, :category_id, :string

  end
end
