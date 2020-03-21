class Post < ActiveRecord::Base
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :comments
  has_many :users, through: :comments

  def categories_attributes=(categories_hashes)
    categories_hashes.each do |i, attr|
      if attr[:name].present?
        category = Category.find_or_create_by(name: attr[:name])
        if !self.categories.include?(category)
          self.post_categories.build(:category => category)
        end
      end
    end
  end

  def comments_users
    comments_users = []
    self.comments.each do |comment|
      if comment.user_id
        comments_users << User.find(comment.user_id) if  comments_users.none?(User.find(comment.user_id))
      end
    end
    comments_users
  end

end