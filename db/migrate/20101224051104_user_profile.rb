class UserProfile < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.remove    :crypted_password #take out :null => false
      t.string    :crypted_password #,    :null => false

      t.remove    :password_salt #take out,       :null => false                # optional, but highly recommended
      t.string    :password_salt #,       :null => false                # optional, but highly recommended
      # will need to destroy all users and re-seed
      
      t.string    :zipcode
      t.integer   :metrocode
      t.float     :lat
      t.float     :lng
    end
    
    add_index  :users, [:lat, :lng]
  end

  def self.down
    change_table :users do |t|
      # t.remove    :crypted_password
      # t.string    :crypted_password,    :null => false
      t.remove    :zipcode
      t.remove   :metrocode
      t.remove     :lat
      t.remove     :lng
    end
    
    remove_index  :users, [:lat, :lng]
  end
end
