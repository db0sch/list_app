class Resource < ApplicationRecord
  has_many :comments, as: :commentable, dependent: :destroy
  belongs_to :collection

  validates_associated :collection

  validates :title, :uri, presence: true;
  validates :title, length: { minimum: 5, maximum: 100 }

  #acts_as_votable gem to let users upvote or downvote this model.
  acts_as_votable

  #public_acitivity gem
  include PublicActivity::Common

end
