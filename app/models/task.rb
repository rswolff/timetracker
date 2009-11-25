class Task < ActiveRecord::Base
  acts_as_taggable_on :tags
  
  belongs_to :user
  
  validates_presence_of :start, :stop, :notes
  
  attr_accessor :end_session, :tags
  named_scope :today, lambda {{:conditions => ["DATE(start) = '#{Time.zone.today}'"], :order => "start DESC"}}

  def calculate_elapsed_time
    self.stop - self.start
  end
  
  def scan_for_hashtags
    self.notes.scan(/(?:\s|\A)[##]+([\w_]+)/)
  end
  
  def add_hashtags
    hashtags = scan_for_hashtags
    if hashtags.empty?
      #set the not_tagged flag
      self.not_tagged = true
    else
      self.tag_list = hashtags
    end
  end
end
