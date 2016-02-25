class AddVineToStories < ActiveRecord::Migration
  def change
    add_column :stories, :vine, :string
  end
end
