class CreatePartnerInstaAccountFollowings < ActiveRecord::Migration[5.1]
  def change
    create_table :partner_insta_account_followings do |t|
      t.date :followed_at
      t.boolean :unfollow, default: false
      t.date :unfollowed_at
      t.integer :following_id, index: true
      t.integer :partner_insta_account_id

      t.timestamps
    end
    add_index :partner_insta_account_followings, :partner_insta_account_id, name: "partner_insta_account_followings_index"
  end
end
