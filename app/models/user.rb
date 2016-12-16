class User < ApplicationRecord
  has_many :collections, dependent: :destroy
  has_many :resources, through: :collections
  has_many :comments, dependent: :destroy


  # in order to put some validation of uniqueness on the name... We shall edit the devise form to add the name field for ex.
  validates :username, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  # acts_as_follower gem in order to allow users to follow another user.
  acts_as_follower # 'acts_as_follower' enables users to follow someone/something.
  acts_as_followable   # 'acts_as_followable' enables users to followed.

  # acts_as_votable gem in order to upvote/downvote a collection or a resources
  acts_as_voter

  def full_name
    "#{first_name} #{last_name}"
  end


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
