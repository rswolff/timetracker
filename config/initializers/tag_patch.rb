class Tag < ActiveRecord::Base
  has_and_belongs_to_many :categories
  
  def Tag.scan(string)
    hash_tags = string.scan(/(?:\s|\A)[##]+([\w_]+)/)
  end
  
  def to_hashtag
    "#" << self.name
  end
end