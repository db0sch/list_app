class AddTaglineToCollections < ActiveRecord::Migration[5.0]
  def change
    add_column :collections, :tagline, :string
  end
end
