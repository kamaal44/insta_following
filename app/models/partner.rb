class Partner < ApplicationRecord
  has_many :partner_insta_accounts
  has_many :insta_accounts, through: :partner_insta_accounts, dependent: :destroy
end
