class AddPersistenceTokenToUsers < ActiveRecord::Migration
  def change
     add_index :users, ["persistence_token"], :name => "index_users_on_persistence_token", :unique => true
  end
end
