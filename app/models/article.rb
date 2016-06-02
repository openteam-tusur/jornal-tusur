class Article < ActiveRecord::Base

  belongs_to :issue
  belongs_to :section
  has_many :article_authors, dependent: :destroy
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

  normalize_attributes :title, :ru_annotation, :en_annotation,
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
  friendly_id :title

  scope :ordered, -> { order :page_from }

  has_attached_file :file, storage: :elvfs, elvfs_url: Settings['storage.url']
  validates_attachment :file, presence: true,
    content_type: { content_type: 'application/pdf' }

  def ru_keyword_list
    ru_keywords.map(&:name).join(', ')
  end

  def en_keyword_list
    en_keywords.map(&:name).join(', ')
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
