class CreateAssessments < ActiveRecord::Migration[7.0]
  def change
    create_table :assessments do |t|
      t.references :student, null: false, foreign_key: true
      t.integer :week
      t.integer :status
      t.integer :comprehension
      t.string :reviewer
      t.text :notes

      t.timestamps
    end
  end
end
