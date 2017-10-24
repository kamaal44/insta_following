class CreateFollowings < ActiveRecord::Migration[5.1]
  def change
    create_table :followings do |t|

      t.timestamps
    end
  end
end
