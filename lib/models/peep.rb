class Peep
  # class Link
  #   include DataMapper::Resource

  #   storage_names[:default] = 'peep_links'

  #   # the person who is following someone (follower)
  #   belongs_to :reply, 'Peep', :key => true

  #   # the person who is followed by someone (followed)
  #   belongs_to :parent, 'Peep', :key => true
  # end

	include DataMapper::Resource

  property :id, Serial
  property :message, Text
  property :time, Time

  belongs_to :maker

  has n, :replies, self, :child_key => [ :original_id ]
  belongs_to :original,  self, :required => false #Top level comments have none.
  
  # # In this relationship, the person is the follower
  # has n, :links_to_parents, 'Peep::Link', :child_key => [:reply_id]

  # # In this relationship, the person is the one followed by someone
  # has n, :links_to_replies, 'Peep::Link', :child_key => [:parent_id]

  # has n, :parents, self,
  #        :through => :links_to_parents, # The person is a follower
  #        :via     => :parent

  # has n, :replies, self,
  #        :through => :links_to_replies, # The person is followed by someone
  #        :via     => :reply

  # def reply_to(others)
  #   parents.concat(Array(others))
  #   save
  #   self
  # end

  def short_time
  	time.strftime "%b %-d"
  end

  def long_time
  	time.strftime "%-l:%M %p - %-d %b %Y"
  end
end