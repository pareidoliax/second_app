class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  attr_accessible :body
  after_create :send_favorites_emails
  private

  def send_favorites_emails
    self.post.favorites.each do |favorites|
      FavoriteMailer.new_comment(favorite.user, self.post, self).deliver
    end
  end
end
