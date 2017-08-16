class CreateConcerts < ActiveRecord::Migration[5.0]
  def change
    create_table :concerts do |t|
      t.date :cdate
      t.references :venue, foreign_key: true

      t.timestamps
    end
  end
end
