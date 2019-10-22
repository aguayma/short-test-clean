class AddTitleToShortUrl < ActiveRecord::Migration[6.0]
  def change
    add_column :short_urls, :title, :string
  end
end
