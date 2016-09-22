class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  validates :user, presence: true;
  validates :content, presence: true;
  validates :content, length: { minimum: 5 };

  # public_activity gem
  include PublicActivity::Common

end
