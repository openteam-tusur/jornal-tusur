class Author < ActiveRecord::Base

  has_many :article_authors, dependent: :destroy
  has_many :articles, through: :article_authors

  validates_presence_of :ru_surname, :ru_name

  normalize_attributes :ru_surname, :ru_name, :ru_patronymic, with: :squish do |value|
    if value.present?
      value.mb_chars.downcase.gsub(/\s+/, '-').split('-').map(&:capitalize).join('-').to_s
    else
      value
    end
  end

  normalize_attributes :phone, :email, with: [:squish, :downcase]

  before_validation :set_en_attributes

  searchable do
    text :ru_surname
    text :ru_name
    text :ru_patronymic
    integer :id
  end

  def ru_fullname
    [
      ru_surname,
      ru_name,
      ru_patronymic
    ].delete_if(&:blank?).join(' ')
  end

  def ru_shortname
    ru_fullname.gsub(/(?<=\s[А-Я|Ё])[а-я|ё]+/, '.')
  end

  def en_fullname
    [
      en_surname,
      en_name,
      en_patronymic
    ].delete_if(&:blank?).join(' ')
  end

  def en_shortname
    en_shortname = [en_surname]
    en_shortname << (en_name[0] == 'Y' ? en_name[0..1] : en_name[0]) + '.'
    en_shortname << (en_patronymic[0] == 'Y' ? en_patronymic[0..1] : en_patronymic[0]) + '.' if en_patronymic.present?

    en_shortname.join(' ')
  end

  def shortname
    send "#{I18n.locale}_shortname"
  end

  def fullname
    send "#{I18n.locale}_fullname"
  end

  private

    def set_en_attributes
      self.en_surname = Russian.transliterate(self.ru_surname)
      self.en_name = Russian.transliterate(self.ru_name)
      self.en_patronymic = Russian.transliterate(self.ru_patronymic)
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
