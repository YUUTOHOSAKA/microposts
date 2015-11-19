class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.references :follower, index: true 
      t.references :followerd, index: true

      t.timestamps null: false
      
      t.index [:follower_id, :followed_id], unique: true # followed_idのペアが他のrelationshipとは異なるように、複合インデックスを設定
    end
  end
end
