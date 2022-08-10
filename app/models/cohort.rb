class Cohort < ApplicationRecord

  # Broadcast changes in realtime with Hotwire
  after_create_commit  -> { broadcast_prepend_later_to :cohorts, partial: "cohorts/index", locals: { cohort: self } }
  after_update_commit  -> { broadcast_replace_later_to self }
  after_destroy_commit -> { broadcast_remove_to :cohorts, target: dom_id(self, :index) }
end
