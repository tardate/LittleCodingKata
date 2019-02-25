class Article < ActiveRecord::Base
  attr_accessible :text, :title
  validates :title, presence: true, length: { minimum: 5 }
end
