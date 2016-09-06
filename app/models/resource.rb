class Resource < ApplicationRecord
  has_many :comments, as: :commentable, dependent: :destroy
  belongs_to :collection

  validates_associated :collection

  validates :title, :uri, presence: true;
  validates :title, length: { minimum: 5, maximum: 100 }
end
