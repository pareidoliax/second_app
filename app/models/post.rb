class Post < ActiveRecord::Base
  has_many :comments
  attr_accessible :body, :title
  belongs_to :user
end
