class TranslateTitleInArticles < ActiveRecord::Migration
  def up
    Article.create_translation_table! title: :text, slug: :string
    Article.find_each do |article|
      article.update_attributes title_ru: article.ru_title, title_en: article.en_title
    end
    remove_column :articles, :ru_title
    remove_column :articles, :en_title
  end

  def down
    add_column :articles, :ru_title, :text
    add_column :articles, :en_title, :text
    Article.find_each do |article|
      article.update_attributes ru_title: article.title_ru, en_title: article.title_en
    end
    Article.drop_translation_table!
  end
end
