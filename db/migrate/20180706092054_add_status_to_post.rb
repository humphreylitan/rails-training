class AddStatusToPost < ActiveRecord::Migration[5.2]
  def up
    add_column :posts, :status, :string, default: "draft"
  end

  def down
    remove_column :posts, :status
  end
end
