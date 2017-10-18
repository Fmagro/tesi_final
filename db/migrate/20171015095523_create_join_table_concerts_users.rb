class CreateJoinTableConcertsUsers < ActiveRecord::Migration[5.0]
  def change
    create_join_table :concerts, :users do |t|
      # t.index [:concert_id, :user_id]
      # t.index [:user_id, :concert_id]
    end
  end
end
