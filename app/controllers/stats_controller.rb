class StatsController < ApplicationController
  # GET /stats
  # GET /stats.xml
  def index
    first = Stat.first(:order => "updated_at DESC")
    @last_updated = first ? first.updated_at.strftime("%B %d, %Y %l:%M%p").gsub(/AM/, "am").gsub(/PM/, "pm") : nil
    respond_to do |format|
      format.html # index.html.erb
      format.json {
        render :json => Stat.aggregate.all(:conditions => @conditions)
      }
    end
  end

  # POST /stats
  # POST /stats.xml
  def create
    saved = Stat.track(params[:json], params[:secret])
    respond_to do |format|
      if saved
        format.json  { render :text => "OK", :status => :ok }
      else
        format.json  { render :json => @stat.errors, :status => :unprocessable_entity }
      end
    end
  end

end
