class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :table
    end
  end
end
