class AddColumnToGroups < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :name, :string
    add_column :groups, :introduction, :string
    add_column :groups, :image_id, :string
    add_column :groups, :owner_id, :integer
  end
end
