class User < ApplicationRecord
  has_many :collections, dependent: :destroy
  has_many :resources, through: :collections
  has_many :comments, dependent: :destroy

  # in order to put some validation of uniqueness on the name... We shall edit the devise form to add the name field for ex.

  # acts_as_follower gem in order to allow users to follow another user.
  # 'acts_as_followable' enables users to followed.
  acts_as_followable
  # 'acts_as_follower' enables users to follow someone/something.
  acts_as_follower


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
