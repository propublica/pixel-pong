require 'test_helper'

class SearchControllerTest < ActionController::TestCase
  should "return url hit counts" do
    stat = Factory :stat
    time = Time.now.to_i
    get :index, 'url' => Stat.first.url, 'callback' => "test#{time}", :format => "json"
    assert_response :success
    assert_equal @response.body, "test#{time}(#{Stat.aggregate.first(:conditions => { :url => stat.url}).to_json});"
  end
end