class Task < ActiveRecord::Base
  acts_as_taggable_on :tags
  
  attr_accessor :end_session, :tags
  
  named_scope :today, lambda { {:conditions => ["DATE(start) >= #{Date.today}"], :order => "start DESC"} }
end
