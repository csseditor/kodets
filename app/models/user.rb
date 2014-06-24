class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :organisation

  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :first_name, :last_name, presence: true
end
