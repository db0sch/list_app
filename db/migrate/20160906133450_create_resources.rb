class CreateResources < ActiveRecord::Migration[5.0]
  def change
    create_table :resources do |t|
      t.string :title
      t.text :content
      t.text :uri
      t.references :collection, foreign_key: true

      t.timestamps
    end
  end
end
