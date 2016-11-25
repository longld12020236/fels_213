class CreateResultLessons < ActiveRecord::Migration[5.0]
  def change
    create_table :result_lessons do |t|
      t.references :lesson, foreign_key: true
      t.references :answer, foreign_key: true

      t.timestamps
    end
  end
end
