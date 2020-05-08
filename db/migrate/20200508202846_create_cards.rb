class CreateCards < ActiveRecord::Migration[6.0]
  def change
    create_table :cards do |t|
      t.string :card_id
      t.belongs_to :boss, null: false, foreign_key: true

      t.timestamps
    end
  end
end
