class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  validates :user, presence: true;
  validates :content, presence: true;
end
