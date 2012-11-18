require 'spec_helper'

describe "pagination" do
  it "should be Search Engines Optimized" do
    get("/membres/page/3").should route_to(controller: "users", action: "index", page: 3)
    get("/jobs/page/5").should route_to(controller: "jobs", action: "index", page: 5)
  end
end
