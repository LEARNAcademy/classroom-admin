class CreateCohorts < ActiveRecord::Migration[7.0]
  def change
    create_table :cohorts do |t|
      t.string :cohort_name
      t.integer :cohort_year

      t.timestamps
    end
  end
end
