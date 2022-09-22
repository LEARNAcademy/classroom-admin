class CreateStudents < ActiveRecord::Migration[7.0]
  def change
    create_table :students do |t|
      t.references :cohort, null: false, foreign_key: true
      t.string :student_name
      t.integer :absences

      t.timestamps
    end
  end
end
