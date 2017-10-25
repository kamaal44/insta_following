class CreatePartnerInstaAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :partner_insta_accounts do |t|
      t.references :insta_account, index: true
      t.references :partner, index: true

      t.timestamps
    end
  end
end
