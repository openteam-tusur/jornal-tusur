class Author < ActiveRecord::Base

  has_many :article_authors, dependent: :destroy
  has_many :articles, through: :article_authors

  searchable do
    text :ru_surname
    text :ru_name
    text :ru_patronymic
    integer :id
  end

  def ru_fullname
    "#{ru_surname} #{ru_name} #{ru_patronymic}"
  end

  def ru_shortname
    ru_fullname.gsub(/(?<=\s[А-Я|Ё])[а-я|ё]+/, '.')
  end

  def en_fullname
    "#{en_surname} #{en_name} #{en_patronymic}"
  end

  def en_shortname
    en_fullname.gsub(/(?<=\s[A-Z])[a-z]+/, '.')
  end

end

# == Schema Information
#
# Table name: authors
#
#  id            :integer          not null, primary key
#  directory_id  :integer
#  ru_surname    :string
#  ru_name       :string
#  ru_patronymic :string
#  en_surname    :string
#  en_name       :string
#  en_patronymic :string
#  post          :text
#  phone         :string
#  email         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
