class CreateServices < ActiveRecord::Migration
  def self.up
    create_table :services do |t|
      t.string :provider
      t.string :uid
      t.text :credentials
      t.text :info
      t.belongs_to :user
      t.timestamps
    end
    
    add_index :services, [:provider, :uid], unique: true
    add_index :services, :user_id
  end

  def self.down
    drop_table :services
  end
end
