class CreateUserAuthentications < SpreeExtension::Migration[4.2]
  def change
    create_table :spree_user_authentications do |t|
      t.integer :user_id
      t.string :provider
      t.string :uid
      t.timestamps null: false
    end

    add_index :spree_user_authentications, [:uid, :provider], unique: true
    add_index :spree_user_authentications, :user_id
  end
end