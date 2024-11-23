class ChangeBookCommnetsToBookComments < ActiveRecord::Migration[6.1]
  def change
    rename_table :book_commnets, :book_comments
  end
end
