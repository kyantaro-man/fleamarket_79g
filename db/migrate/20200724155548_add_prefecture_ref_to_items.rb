class AddPrefectureRefToItems < ActiveRecord::Migration[6.0]
  def change
    add_reference :items, :prefecture, null: false,foreign_key: true
  end
end
