class Post < ApplicationRecord
  belongs_to :group, optional: true
  belongs_to :post, optional: true

  has_many :comments, class_name: 'Post'

  has_rich_text :content
end
