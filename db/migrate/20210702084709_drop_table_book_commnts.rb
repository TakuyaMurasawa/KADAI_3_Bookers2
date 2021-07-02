class DropTableBookCommnts < ActiveRecord::Migration[5.2]
  def change
    drop_table :book_commnts
  end
end
