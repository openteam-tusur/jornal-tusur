class RenameArticleFields < ActiveRecord::Migration
  def change
    rename_column :articles, :title_ru, :ru_title
    rename_column :articles, :title_en, :en_title
    rename_column :articles, :annotation_ru, :ru_annotation
    rename_column :articles, :annotation_en, :en_annotation
  end
end
