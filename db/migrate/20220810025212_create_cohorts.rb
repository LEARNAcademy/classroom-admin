class CreateCohorts < ActiveRecord::Migration[7.0]
  def change
    create_table :cohorts do |t|
      t.string :cohort_name

      t.timestamps
    end
  end
end
