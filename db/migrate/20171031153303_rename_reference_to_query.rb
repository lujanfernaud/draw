class RenameReferenceToQuery < ActiveRecord::Migration[5.1]
  def change
    rename_column :requests, :reference, :query
  end
end
