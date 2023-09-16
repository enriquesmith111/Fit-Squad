class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :workout_preference
  has_many :groups

  def groups
    # This method returns a collection of all the groups that the user belongs to.
    return Group.where(user_id: id)
  end
end
