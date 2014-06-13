class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.string :name
      t.string :email
      t.belongs_to :account
      t.belongs_to :user
      t.belongs_to :project
      t.integer :access
      t.datetime :accepted_at
      t.belongs_to :inviter
      t.string :token
      t.timestamps
    end
    
    add_index :memberships, [:account_id, :user_id, :project_id], unique: true
    add_index :memberships, [:project_id, :email], unique: true
  end
end
