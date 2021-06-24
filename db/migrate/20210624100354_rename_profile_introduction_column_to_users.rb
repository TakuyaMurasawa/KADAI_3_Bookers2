class RenameProfileIntroductionColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :profile_Introduction, :introduction
  end
end
