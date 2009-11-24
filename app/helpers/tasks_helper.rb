module TasksHelper
  def format_seconds_as_hours_minutes(seconds)
    [seconds/3600, seconds/60 % 60].map{|t| t.to_s.rjust(2,'0')}.join(':')
  end
end
