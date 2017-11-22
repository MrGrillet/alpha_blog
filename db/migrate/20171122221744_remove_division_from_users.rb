class RemoveDivisionFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :password_diegest, :string
  end
end
