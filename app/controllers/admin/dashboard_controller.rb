module Admin
  class DashboardController < Admin::ApplicationController
    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information
    def show
      @users = ::User.all.count
    end
  end
end
