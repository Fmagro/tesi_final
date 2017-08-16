class CreatePerformances < ActiveRecord::Migration[5.0]
  def change
    create_table :performances do |t|
      t.integer :position
      t.references :concert, foreign_key: true
      t.references :song, foreign_key: true

      t.timestamps
    end
  end
end
