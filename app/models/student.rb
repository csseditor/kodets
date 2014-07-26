class Student < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable

  belongs_to :organisation

  before_create :check_population

  validates :name, presence: true, on: :update
  validates :password, presence: true

  private

  def check_population
    # change when max_users is added to Orgs
    org = Organisation.find(self.organisation_id)
    if org.users.count >= org.max_users
      raise Exceptions::MaximumPopulationReached, 'You have surpassed your maximum amount of users.'
    end
  end
end
