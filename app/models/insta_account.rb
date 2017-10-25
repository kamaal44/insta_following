class InstaAccount < ApplicationRecord
  has_many :partner_insta_accounts
  has_many :partners,  through: :partner_insta_accounts
end
