class Comment < ApplicationRecord
  belongs_to :micropost
  belongs_to :user

  default_scope ->  {order(created_at: :asc)}
  validates :micropost, presence: true
  validates :content, presence: true, length: {maximum: 140}
end
