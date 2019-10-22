class ChangeColumnNameInShortUrl < ActiveRecord::Migration[6.0]
  def change
    rename_column :short_urls, :url, :full_url
    rename_column :short_urls, :code, :short_code
  end
end
