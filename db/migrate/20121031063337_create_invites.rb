class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.string :token
      t.string :name
      t.string :email
      t.datetime :accepted_at
      t.belongs_to :user
      t.belongs_to :project
      t.belongs_to :invited_by
      t.timestamps
    end
  end
end
