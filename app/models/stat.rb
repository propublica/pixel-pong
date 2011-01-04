$KCODE = 'UTF-8'
class Stat < ActiveRecord::Base
  validates_presence_of :url, :hits
  validate_on_create :log_hits?
  validate :url_format
  named_scope :aggregate, :order => "hits DESC", :select => ["sum(hits) as hits, url, title"], :group => :url


  def title=(t)
    write_attribute :title, HTML::FullSanitizer.new.sanitize(t)
  end

  def title
    t = read_attribute :title
    if t.nil?
      begin
        req = Curl::Easy.new(url)
        req.perform
        self.title = Nokogiri::HTML.parse(req.body_str).css('title').text
      # catch bad urls
      rescue Curl::Err::HostResolutionError
        self.title = "Inaccessible URL"
      ensure
        save
      end
    end
    self.title = "No Title" if read_attribute(:title).blank?
    read_attribute :title
  end

  private

  def url_format
    u = URI.parse url
    case
    when u.scheme.nil? then errors.add(:url, "no scheme")
    when u.host.nil? then errors.add(:url, "no host")
    end
  rescue URI::BadURIError, URI::InvalidURIError
    errors.add(:url, "bad url")
  end

  def record_todays_date
    self.date_for = Date.today
  end

  def log_hits?
    record_todays_date
    if Stat.exists? :url => url, :date_for => date_for
      stat = Stat.first(:conditions => {:url => url, :date_for => date_for})
      self.id = stat.id
      new_hits = hits
      reload
      @new_record = false
      errors.clear
      increment(:hits, new_hits)
    end
    true
  end

  public

  def self.track(json, secret)
    raw_stats = JSON.parse(json)
    if secret == PIXEL_SECRET
      raw_stats.each do |component, hits|
        if component.include? "|pixel-ping-break|"
          bits = component.split "|pixel-ping-break|"
          title = bits.shift
          url = bits.pop
        else
          title = nil
          url = component
        end
        stat = Stat.new(:title => title, :url => url, :hits => hits)
        stat.save
        stat.delay.title if title.nil?
      end
      return true
    end
    false
  end
end
