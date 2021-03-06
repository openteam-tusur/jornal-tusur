class Article < ActiveRecord::Base

  belongs_to :issue
  belongs_to :section
  has_many :article_authors, -> { order(:id) }, dependent: :destroy
  has_many :authors, through: :article_authors

  translates :title, :slug

  globalize_accessors locales: I18n.available_locales, attributes: translated_attribute_names

  globalize_validations
  validates :title, presence: true
  validates :title, uniqueness: {
    scope: :issue_id,
    message: 'Статья с таким названием уже есть в этом номере журнала'
  }
  validate :validates_globalized_attributes

  validates_presence_of :ru_annotation, :en_annotation,
    :page_from, :page_to

  validate :page_from_larger_page_to

  normalize_attributes :title, :title_ru, :title_en,
    :ru_annotation, :en_annotation,
    :page_from, :page_to, with: :squish

  normalize_attributes :ru_keyword_list, :en_keyword_list, with: [:squish, :blank, :downcase] do |value|
    if value.present?
      value.gsub('.', '').gsub(';', ',')
    else
      value
    end
  end

  acts_as_taggable_on :ru_keywords, :en_keywords

  extend FriendlyId
  friendly_id :title, use: :globalize

  scope :ordered, -> { order :page_from }
  scope :ordered_by_title, -> { with_translations(I18n.locale).order(:title) }
  scope :without_authors, -> { includes(:article_authors).where(article_authors: { author_id: nil }) }
  scope :published, -> { ordered_by_title.joins(:issue).where(issues: { aasm_state: :published }) }

  has_attached_file :file, storage: :elvfs, elvfs_url: Settings['storage.url']
  validates_attachment :file, presence: true,
    content_type: { content_type: 'application/pdf' }

  def annotation
    send("#{I18n.locale}_annotation")
  end

  def ru_keyword_list
    ru_keywords.map(&:name).join(', ')
  end

  def en_keyword_list
    en_keywords.map(&:name).join(', ')
  end

  def keywords
    send("#{I18n.locale}_keyword_list")
  end

  def bibliography
    bibliography = [
      authors.first.ru_shortname,
      title_ru,
      '/',
      authors_for_bibliography,
      '//',
      'Доклады ТУСУР.',
      '–',
      "#{issue.year}.",
      '–',
      issue.bibliography_number,
      '–',
      "С. #{page_from}-#{page_to}."
    ].join(' ')
  end

  def authors_for_bibliography
    result = []
    if authors.count > 3
      result << authors.first.ru_reverse_shortname
      result << '[и др.]'
    else
      result << authors.map(&:ru_reverse_shortname).join(', ')
    end

    result.flatten.join(' ')
  end

  private

    def page_from_larger_page_to
      if page_from.to_i >= page_to.to_i
        errors.add(:page_to, 'не может быть меньше или равной стартовой странице')
      end
    end

end

# == Schema Information
#
# Table name: articles
#
#  id                :integer          not null, primary key
#  issue_id          :integer
#  ru_annotation     :text
#  en_annotation     :text
#  page_from         :integer
#  page_to           :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  file_file_name    :string
#  file_content_type :string
#  file_file_size    :integer
#  file_updated_at   :datetime
#  file_url          :text
#  ru_keywords       :text
#  en_keywords       :text
#  section_id        :integer
#
# Indexes
#
#  index_articles_on_issue_id    (issue_id)
#  index_articles_on_section_id  (section_id)
#
# Foreign Keys
#
#  fk_rails_582ee7da77  (section_id => sections.id)
#  fk_rails_e2f71d0bb7  (issue_id => issues.id)
#
