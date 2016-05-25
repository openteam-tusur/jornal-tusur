class Section < ActiveRecord::Base

  validates_presence_of :ru_title, :en_title

  normalize_attributes :ru_title, :en_title, with: :squish

  scope :ordered, -> { order :ru_title }

end

# == Schema Information
#
# Table name: sections
#
#  id         :integer          not null, primary key
#  ru_title   :string
#  en_title   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
