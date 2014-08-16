class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :organisation

  validates :name,     presence: true
  validates :username, presence: true, uniqueness: { case_sensitive: false,
                                                     scope: :organisation,
                                                     message: 'must be unique' }

  def teacher?
    teacher
  end
end
