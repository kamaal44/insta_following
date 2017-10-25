class CreateFollowings < ActiveRecord::Migration[5.1]
  def change
    create_table :followings do |t|
      t.string :name

      t.timestamps
    end
  end
end
