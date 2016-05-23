class AddKeywordsToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :ru_keywords, :text
    add_column :articles, :en_keywords, :text
  end
end
