class Tag < ActiveRecord::Base
  belongs_to :categories
  
  def Tag.scan(string)
    hash_tags = string.scan(/(?:\s|\A)[##]+([\w_]+)/)
  end
  
  def to_hashtag
    "#" << self.name
  end
end