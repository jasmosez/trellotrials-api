class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :card_a_id
      t.string :card_b_id

      t.timestamps
    end
  end
end
