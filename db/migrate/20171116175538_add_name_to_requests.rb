class AddNameToRequests < ActiveRecord::Migration[5.1]
  def change
    add_column :requests, :name, :string
  end
end
