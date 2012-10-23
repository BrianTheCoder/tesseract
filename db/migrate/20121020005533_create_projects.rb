class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.string :slug
      t.belongs_to :account
      t.timestamps
    end
  end
end
