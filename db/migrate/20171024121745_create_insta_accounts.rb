class CreateInstaAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :insta_accounts do |t|

      t.timestamps
    end
  end
end
