require 'test_helper'

class SearchControllerTest < ActionController::TestCase
  should "return url hit counts" do
    stat = Factory :stat
    get :index, 'url' => Stat.first.url, 'callback' => 'test', :format => "json"
    assert_response :success
    assert_equal @response.body, "test(#{Stat.aggregate.first(:conditions => { :url => stat.url}).to_json});"
  end
end