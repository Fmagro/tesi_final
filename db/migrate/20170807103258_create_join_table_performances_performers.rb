class CreateJoinTablePerformancesPerformers < ActiveRecord::Migration[5.0]
  def change
    create_join_table :performances, :performers do |t|
      # t.index [:performance_id, :performer_id]
      # t.index [:performer_id, :performance_id]
    end
  end
end
