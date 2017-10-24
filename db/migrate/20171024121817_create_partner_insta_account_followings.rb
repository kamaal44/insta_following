class CreatePartnerInstaAccountFollowings < ActiveRecord::Migration[5.1]
  def change
    create_table :partner_insta_account_followings do |t|

      t.timestamps
    end
  end
end
