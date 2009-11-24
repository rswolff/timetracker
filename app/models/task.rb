class Task < ActiveRecord::Base
  acts_as_taggable_on :tags
  
  belongs_to :user
  
  attr_accessor :end_session, :tags
  named_scope :today, lambda {{:conditions => ["DATE(start) = '#{Time.zone.today}'"], :order => "start DESC"}}
end
