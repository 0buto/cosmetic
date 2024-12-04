class CreateReviews < ActiveRecord::Migration[8.0]
  def change
    create_table :reviews do |t|
      t.string :name
      t.text :content

      t.timestamps
    end
  end
end
