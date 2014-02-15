class Peep
	include DataMapper::Resource

  property :id, Serial
  property :message, Text
  property :time, Time

  belongs_to :maker

  def short_time
  	time.strftime "%b %-d"
  end

  def long_time
  	time.strftime "%-l:%M %p - %-d %b %Y"
  end
end