class AddTwitterToStory < ActiveRecord::Migration
  def change
    add_column :stories, :twitter, :string
  end
end
