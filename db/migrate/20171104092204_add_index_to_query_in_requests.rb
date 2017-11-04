class AddIndexToQueryInRequests < ActiveRecord::Migration[5.1]
  def change
    add_index :requests, :query
  end
end
