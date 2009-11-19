class Task < ActiveRecord::Base
  attr_accessor :end_session
  
  named_scope :today, lambda { {:conditions => ["DATE(start) >= #{Date.today}"], :order => "start DESC"} }
end
