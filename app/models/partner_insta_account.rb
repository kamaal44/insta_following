class PartnerInstaAccount < ApplicationRecord
  belongs_to :insta_account
  belongs_to :partner

  has_many :partner_insta_account_followings
  has_many :followings, through: :partner_insta_account_followings

end
