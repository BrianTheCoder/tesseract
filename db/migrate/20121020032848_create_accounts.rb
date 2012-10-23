class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :slug
      t.text :billing_info
      
      t.timestamps
    end
    
    add_index :accounts, :slug, unique: true
  end
end
