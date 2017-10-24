class CreatePartnerInstaAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :partner_insta_accounts do |t|

      t.timestamps
    end
  end
end
