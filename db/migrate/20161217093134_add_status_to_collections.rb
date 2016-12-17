class AddStatusToCollections < ActiveRecord::Migration[5.0]
  def change
    add_column :collections, :status, :integer, default: 0, index: true
  end
end
