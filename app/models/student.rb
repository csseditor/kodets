class Student < ActiveRecord::Base
  devise :database_authenticatable, :trackable, :timeoutable, :lockable

  belongs_to :organisation

  validates :name, presence: true, on: :update
end
