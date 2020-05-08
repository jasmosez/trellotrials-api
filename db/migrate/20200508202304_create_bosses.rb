class CreateBosses < ActiveRecord::Migration[6.0]
  def change
    create_table :bosses do |t|
      t.string :desc
      t.string :name

      t.timestamps
    end
  end
end
