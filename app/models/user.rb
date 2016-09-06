class User < ApplicationRecord
  has_many :collections, dependent: :destroy
  has_many :resources, through: :collections
  has_many :comments, dependent: :destroy

  # in order to put some validation of uniqueness on the name... We shall edit the devise form to add the name field for ex.


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
