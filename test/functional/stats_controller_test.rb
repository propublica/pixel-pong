require 'test_helper'

class StatsControllerTest < ActionController::TestCase
  should "get index" do
    get :index
    assert_response :success
  end

  should "create stat" do
    assert_difference('Stat.count', 2) do
      post :create, :json => { 
        "http://www.propublica.org/pages/about.html" => 276, 
        "http://www.propublica.org/articles/policy.html" => 324, 
      }.to_json,
      :secret => PIXEL_SECRET
    end
    assert_response :ok
  end

end
