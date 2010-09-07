class StatsController < ApplicationController
  # GET /stats
  # GET /stats.xml
  def index
    @today = Date.today.to_time
    conditions = ["created_at > ? and created_at <= ?", @today, @today + 1.day]
    conditions = ["created_at > ? and created_at <= ?", Time.parse(params[:start_date]).to_date.to_time, Time.parse(params[:end_date]).to_date.to_time + 1.day] if params[:start_date] && params[:end_date]
    first = Stat.first(:order => "updated_at DESC")
    @last_updated = first ? first.updated_at.strftime("%B %d, %Y %l:%M%p").gsub(/AM/, "am").gsub(/PM/, "pm") : nil
    respond_to do |format|
      format.html # index.html.erb
      format.json {
        render :json => Stat.aggregate.all(:conditions => conditions)
      }
    end
  end

  # GET /stats/1
  # GET /stats/1.xml
  def show
    @stat = Stat.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @stat }
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
