require "rails_helper"

RSpec.describe CohortsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/cohorts").to route_to("cohorts#index")
    end

    it "routes to #new" do
      expect(get: "/cohorts/new").to route_to("cohorts#new")
    end

    it "routes to #show" do
      expect(get: "/cohorts/1").to route_to("cohorts#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/cohorts/1/edit").to route_to("cohorts#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/cohorts").to route_to("cohorts#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/cohorts/1").to route_to("cohorts#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/cohorts/1").to route_to("cohorts#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/cohorts/1").to route_to("cohorts#destroy", id: "1")
    end
  end
end
