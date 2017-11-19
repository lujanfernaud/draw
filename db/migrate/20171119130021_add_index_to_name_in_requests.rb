class AddIndexToNameInRequests < ActiveRecord::Migration[5.1]
  def change
    add_index :requests, :name
  end
end
