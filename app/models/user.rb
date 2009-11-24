require 'digest/sha1'

class User < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken
  include Authorization::AasmRoles
  
  has_many :tasks,  :order => "start"
  
  acts_as_tagger

  validates_presence_of     :login
  validates_length_of       :login,    :within => 3..40
  validates_uniqueness_of   :login
  validates_format_of       :login,    :with => Authentication.login_regex, :message => Authentication.bad_login_message

  validates_format_of       :name,     :with => Authentication.name_regex,  :message => Authentication.bad_name_message, :allow_nil => true
  validates_length_of       :name,     :maximum => 100

  validates_presence_of     :email
  validates_length_of       :email,    :within => 6..100 #r@a.wk
  validates_uniqueness_of   :email
  validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :name, :password, :password_confirmation, :time_zone
  
  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  
  def self.authenticate(login, password)
    return nil if login.blank? || password.blank?
    u = find_in_state :first, :active, :conditions => {:login => login.downcase} # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end
  
  def today_local_start
    Time.zone.local(y=Date.today.year, m=Date.today.mon, d=Date.today.day, h=0, min=0, s=0)
  end
  
  def today_local_end
    Time.zone.local(y=Date.today.year, m=Date.today.mon, d=Date.today.day, h=-1, min=-1, s=-1)
  end
  
  def todays_tasks
    self.tasks.find(:all, :conditions => ['start BETWEEN ? AND ?', self.today_local_start, self.today_local_end ])
  end
  
  def todays_tags
    Tag.find( :all,
              :select =>"tags.id, tags.name, SUM(elapsed_time_in_seconds) AS elapsed_time_in_seconds", 
              :joins => "INNER JOIN taggings ON tags.id = taggings.tag_id INNER JOIN tasks ON taggings.taggable_id = tasks.id",
              :conditions => ['start BETWEEN ? AND ?', self.today_local_start, self.today_local_end],
              :group => "tags.id",
              :order => "elapsed_time_in_seconds DESC, name")
  end

  protected
    
    def make_activation_code
        self.deleted_at = nil
        self.activation_code = self.class.make_token
    end
end
