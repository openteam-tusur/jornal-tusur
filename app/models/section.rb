class Section < ActiveRecord::Base

  translates :title

  globalize_accessors locales: I18n.available_locales, attributes: translated_attribute_names

  globalize_validations
  validates :title, presence: true, uniqueness: true
  validate :validates_globalized_attributes

  normalize_attributes :title, with: :squish

  scope :ordered, -> { with_translations(I18n.locale).order(:title) }

end

# == Schema Information
#
# Table name: sections
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
