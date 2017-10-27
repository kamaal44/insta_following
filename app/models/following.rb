class Following < ApplicationRecord
  has_many :partner_insta_account_followings
  has_many :partner_insta_accounts, through: :partner_insta_account_followings, dependent: :destroy
end
