class Issue < ActiveRecord::Base

  scope :ordered, -> { order year: :desc, number: :desc, part: :desc }

  validates_presence_of :year, :number, :through_number

  default_value_for :year do
    Issue.pluck(:year).max
  end

  default_value_for :number do
    Issue.where(year: Issue.pluck(:year).max).pluck(:number).max + 1
  end

  default_value_for :through_number do
    Issue.pluck(:through_number).max + 1
  end

  def human_number
    human_number = ["№#{number}"]
    human_number << "#{part} часть" if part.present?

    human_number.join(', ')
  end

  def full_number
    [human_number, "[#{through_number}]"].join(' ')
  end

end

# == Schema Information
#
# Table name: issues
#
#  id             :integer          not null, primary key
#  year           :integer
#  number         :integer
#  through_number :integer
#  part           :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#