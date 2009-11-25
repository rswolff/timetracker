ActiveSupport::CoreExtensions::Date::Conversions::DATE_FORMATS.merge!(
  :short => "%Y/%m/%d",
  :med => "%d-%b-%Y",
  :long => "%A %B %d, %Y",
  :military => "%H%M"  
)

ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS.merge!(
  :military => "%H%M",
  :short => "%H:%M %p"  
)