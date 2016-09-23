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

  # ALGOLIA Search Engine
  include AlgoliaSearch

  algoliasearch do
    attribute :title, :content, :uri

    add_attribute :resource_upvotes do
      get_likes.size
    end

    attributesToIndex ['title', 'content', 'uri']

    customRanking ['desc(resource_upvotes)']
  end

end
