class SearchController < ApplicationController
  JS_CLEANER = /[^$_\w]/
  def index
    render :status => 404 and return unless params[:url] && params[:callback]
    @conditions = ["#{@conditions.first} and url = :url", @conditions.last.merge({
      :url => params[:url]
    })]
    respond_to do |format|
      format.json { render :text => "#{params[:callback].gsub(JS_CLEANER, "")}(#{Stat.aggregate.first(:conditions => @conditions).to_json});" }
    end
  end
end