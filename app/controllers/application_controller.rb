# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  before_filter :timeframe
  
  def timeframe
    @today = Time.zone.today
    @conditions = ["created_at > :start_date and created_at <= :end_date", {
      :start_date => @today.beginning_of_day.utc, 
      :end_date   => @today.end_of_day.utc
    }]
    @conditions = ["created_at > :start_date and created_at <= :end_date", {
      :start_date => Time.parse(params[:start_date]).to_date.beginning_of_day.utc, 
      :end_date   => Time.parse(params[:end_date]).to_date.end_of_day.utc
    }] if params[:start_date] && params[:end_date]
  end
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
end
