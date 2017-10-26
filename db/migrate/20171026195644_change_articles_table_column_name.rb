class ChangeArticlesTableColumnName < ActiveRecord::Migration
  def change
    rename_column :articles, :table, :title
  end
end
