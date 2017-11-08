class AddCurrentPagesToRequests < ActiveRecord::Migration[5.1]
  def change
    add_column :requests, :current_pages, :integer, array: true, default: []
  end
end
