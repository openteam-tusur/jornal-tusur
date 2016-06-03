class Claim < ActiveRecord::Base

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

  has_attached_file :file, storage: :elvfs, elvfs_url: Settings['storage.url']
  validates_attachment :file, presence: true
  do_not_validate_attachment_file_type :file

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
#
