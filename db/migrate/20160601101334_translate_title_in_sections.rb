class TranslateTitleInSections < ActiveRecord::Migration
  def up
    Section.create_translation_table! title: :string
    Section.find_each do |section|
      section.update_attributes title_ru: section.ru_title, title_en: section.en_title
    end
    remove_column :sections, :ru_title
    remove_column :sections, :en_title
  end

  def down
    add_column :sections, :ru_title, :string
    add_column :sections, :en_title, :string
    Section.find_each do |section|
      section.update_attributes ru_title: section.title_ru, en_title: section.title_en
    end
    Section.drop_translation_table!
  end
end
