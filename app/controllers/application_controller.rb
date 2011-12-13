# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  before_filter :timeframe
  
  def timeframe
    @today = Date.today.to_time.utc
    @conditions = ["created_at > :start_date and created_at <= :end_date", {
      :start_date => @today, 
      :end_date   => @today + 1.day
    }]
    @conditions = ["created_at > :start_date and created_at <= :end_date", {
      :start_date => Time.parse(params[:start_date]).to_date.to_time.utc, 
      :end_date   => Time.parse(params[:end_date]).to_date.to_time.utc + 1.day
    }] if params[:start_date] && params[:end_date]
  end
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
end
