class AddPreviousPagesToRequests < ActiveRecord::Migration[5.1]
  def change
    add_column :requests, :previous_pages, :integer, array: true, default: []
  end
end
