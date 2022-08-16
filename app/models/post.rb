class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :group, optional: true
  belongs_to :post, optional: true

  has_many :comments, class_name: 'Post', dependent: :destroy

  has_rich_text :content
end
