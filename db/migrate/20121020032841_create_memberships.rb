class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships, id: false do |t|
      t.belongs_to :account
      t.belongs_to :user
      t.belongs_to :project
      t.integer :access
      t.timestamps
    end
    
    add_index :memberships, [:account_id, :user_id, :project_id], unique: true
  end
end
