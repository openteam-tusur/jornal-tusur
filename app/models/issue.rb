class Issue < ActiveRecord::Base

  has_many :articles, dependent: :destroy

  scope :ordered, -> { order year: :desc, number: :desc, part: :desc }

  validates_presence_of :year, :number

  validates :number, uniqueness: {
    scope: [:year, :part],
    message: 'Такой номер журнала уже существует'
  }

  has_attached_file :poster, storage: :elvfs, elvfs_url: Settings['storage.url']
  validates_attachment :poster,
    content_type: { content_type: /\Aimage/ }

  has_attached_file :file, storage: :elvfs, elvfs_url: Settings['storage.url']
  validates_attachment :file,
    content_type: { content_type: 'application/pdf' }

  default_value_for :year do
    Issue.pluck(:year).max
  end

  default_value_for :number do
    Issue.where(year: Issue.pluck(:year).max).pluck(:number).max + 1 rescue nil
  end

  normalize_attributes :year, :number, :through_number, with: :squish
  normalize_attributes :part, with: [:squish, :blank]

  include AASM

  aasm whiny_transitions: false do
    state :draft, initial: true
    state :published

    event :approve do
      transitions from: :draft, to: :published
    end

    event :rollback do
      transitions from: :published, to: :draft
    end
  end

  extend FriendlyId

  friendly_id :slug_candidates

  def slug_candidates
    [
      [:number, :part, :year],
      [:number, :year],
    ]
  end

  def current_state
    aasm.current_state
  end

  def current_human_state
    aasm.human_state
  end

  def human_number
    human_number = ["№#{number}"]
    human_number << "т. #{tome}" if tome.present?
    human_number << "#{part} часть" if part.present?

    human_number.join(', ')
  end

  def full_number
    full_number = [human_number]
    full_number << "[#{through_number}]" if through_number.present?

    full_number.join(' ')
  end

  def title
    I18n.t('app.issue_of_journal', number: full_number, year: year)
  end

end

# == Schema Information
#
# Table name: issues
#
#  id                  :integer          not null, primary key
#  year                :integer
#  number              :integer
#  through_number      :integer
#  part                :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  poster_file_name    :string
#  poster_content_type :string
#  poster_file_size    :integer
#  poster_updated_at   :datetime
#  poster_url          :text
#  aasm_state          :string
#  file_file_name      :string
#  file_content_type   :string
#  file_file_size      :integer
#  file_updated_at     :datetime
#  file_url            :text
#  slug                :string
#  tome                :integer
#
# Indexes
#
#  index_issues_on_slug  (slug) UNIQUE
#
