class CreateRelationships < ActiveRecord::Migration[5.0]
  def change
    create_table :relationships do |t|
      t.integer :follower_id
      t.string :followed_id_integer

      t.timestamps
    end
  end
end
