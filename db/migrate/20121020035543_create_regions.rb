class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      t.string :identifier
      t.integer :x
      t.integer :y
      t.integer :width
      t.integer :height
      t.belongs_to :image
      t.belongs_to :user
      t.belongs_to :project
      t.timestamps
    end
  end
end
