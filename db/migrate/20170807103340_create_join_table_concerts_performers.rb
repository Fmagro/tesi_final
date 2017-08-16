class CreateJoinTableConcertsPerformers < ActiveRecord::Migration[5.0]
  def change
    create_join_table :concerts, :performers do |t|
      # t.index [:concert_id, :performer_id]
      # t.index [:performer_id, :concert_id]
    end
  end
end
