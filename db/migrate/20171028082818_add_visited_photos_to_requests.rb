class AddVisitedPhotosToRequests < ActiveRecord::Migration[5.1]
  def change
    add_column :requests, :visited_photos, :string, array: true, default: []
  end
end
