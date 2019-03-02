class AddForeignKeyToUserAuthenticationsForUserId < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :spree_user_authentications, :spree_users, column: :user_id
  end
end