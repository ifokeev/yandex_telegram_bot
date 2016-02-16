class AddSortToTags < ActiveRecord::Migration[5.0]
  def change
    add_column :tags, :sort, :integer, default: 0
  end
end
