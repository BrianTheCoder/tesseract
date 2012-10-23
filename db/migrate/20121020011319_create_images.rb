class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :file
      t.integer :width
      t.integer :height
      t.belongs_to :project
      t.belongs_to :user
      t.timestamps
    end
  end
end
