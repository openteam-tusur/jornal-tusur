class Claim < ActiveRecord::Base

  belongs_to :issue

  validates_presence_of :surname, :name, :email, :phone, :address, :workplace, :file

  validates :email, email: true

  normalize_attributes :surname, :name, :patronymic, with: :squish do |value|
    if value.present?
      value.mb_chars.downcase.gsub(/\s+/, '-').split('-').map(&:capitalize).join('-').to_s
    else
      value
    end
  end

  normalize_attributes :phone, :address, :workplace, with: :squish

  normalize_attributes :email, with: [:squish, :downcase]

  has_attached_file :file, storage: :elvfs, elvfs_url: Settings['storage.url']
  validates_attachment :file, presence: true
  do_not_validate_attachment_file_type :file

  scope :ordered, -> { order created_at: :desc }

  paginates_per 20

  include AASM

  aasm whiny_transitions: false do
    state :created, initial: true
    state :accepted
    state :rejected

    event :accept do
      transitions from: [:created, :rejected], to: :accepted
    end

    event :reject do
      transitions from: [:created, :accepted], to: :rejected
    end

    event :rollback do
      transitions from: [:accepted, :rejected], to: :created
    end
  end

  def author
    [
      surname,
      name,
      patronymic
    ].delete_if(&:blank?).join(' ')
  end

  def current_state
    aasm.current_state
  end

  def current_human_state
    aasm.human_state
  end

end

# == Schema Information
#
# Table name: claims
#
#  id                :integer          not null, primary key
#  surname           :string
#  name              :string
#  patronymic        :string
#  phone             :string
#  email             :string
#  address           :text
#  workplace         :text
#  file_file_name    :string
#  file_content_type :string
#  file_file_size    :integer
#  file_updated_at   :datetime
#  file_url          :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  aasm_state        :string
#  user_id           :string
#  issue_id          :integer
#
# Indexes
#
#  index_claims_on_issue_id  (issue_id)
#
# Foreign Keys
#
#  fk_rails_34dc6a3746  (issue_id => issues.id)
#
