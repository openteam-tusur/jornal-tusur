class Article < ActiveRecord::Base

  belongs_to :issue

  normalize_attribute :title_ru, :title_en, :annotation_ru, :annotation_en,
    :page_from, :page_to, with: :squish

  validates_presence_of :title_ru, :title_en, :annotation_ru, :annotation_en,
    :page_from, :page_to

  validates :title_ru, uniqueness: {
    scope: :issue_id,
    message: 'Статья с таким названием уже есть в этом номере журнала'
  }

  has_attached_file :file, storage: :elvfs, elvfs_url: Settings['storage.url']
  validates_attachment :file, presence: true,
    content_type: { content_type: 'application/pdf' }

end

# == Schema Information
#
# Table name: articles
#
#  id                :integer          not null, primary key
#  issue_id          :integer
#  title_ru          :text
#  title_en          :text
#  annotation_ru     :text
#  annotation_en     :text
#  page_from         :integer
#  page_to           :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  file_file_name    :string
#  file_content_type :string
#  file_file_size    :integer
#  file_updated_at   :datetime
#  file_url          :text
#
# Indexes
#
#  index_articles_on_issue_id  (issue_id)
#
# Foreign Keys
#
#  fk_rails_e2f71d0bb7  (issue_id => issues.id)
#
