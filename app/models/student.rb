class Student < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable

  belongs_to :organisation

  validates :name,     presence: true, on: :update
end
