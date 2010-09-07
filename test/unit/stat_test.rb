require 'test_helper'

class StatTest < ActiveSupport::TestCase
  context "A stat" do
    setup do
      @stat = Factory.create(:stat)
    end
    
    teardown do
      @stat.delete
    end
    
    should "Have a date on creation" do
      assert_equal(Date.today, @stat.date_for)
    end
    
    should "not save duplicate records" do
      new_stat = Factory.build :stat, :url => @stat.url
      new_hits = new_stat.hits
      old_hits = @stat.hits
      new_stat.save
      @stat.reload
      assert_equal old_hits + new_hits, @stat.hits
    end
    
    should "not allow broken urls" do
      stat = Factory.build :stat, :url => "borked_url"
      assert_equal false, stat.save
    end
    
    should "parse out the title from composite urls" do
      Stat.track({ 
        "Title☃http://www.propublica.org/pages/about.html" => 276, 
      }.to_json, PIXEL_SECRET)
      assert_equal "Title", Stat.last.title
    end
    
    should "catch curling errors" do
      stat = Factory.create :stat, :url => "http://www.borkedurl.com/"
      assert_equal stat.title, "Inaccessible URL"
    end
  end
end
