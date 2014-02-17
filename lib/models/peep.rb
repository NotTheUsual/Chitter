class Peep

	include DataMapper::Resource

  property :id, Serial
  property :message, Text
  property :time, Time

  belongs_to :maker

  has n, :replies, self, :child_key => [ :original_id ]
  belongs_to :original,  self, :required => false #Top level comments have none.

  def short_time
  	time.strftime "%b %-d"
  end

  def long_time
  	time.strftime "%-l:%M %p - %-d %b %Y"
  end
end