class Group < ApplicationRecord
  enum access: { open_group: 0, private_group: 1, secret_group: 2 }

  belongs_to :owner, class_name: 'User'

  has_many :posts
  has_and_belongs_to_many :members, class_name: 'User'

  scope :all_user_visible_groups, ->(current_user) { 
    where(access: [:open_group, :private_group]).or(where(owner: current_user))
  }

  scope :created_by_me, ->(current_user) { 
    where(owner: current_user)
  }
end
