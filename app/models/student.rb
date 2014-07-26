class Student < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable

  belongs_to :organisation

  before_create :check_population

  VALID_USERNAME_REGEXP = /\A^[-a-zA-Z0-9_]*$\z/i
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates :name,     presence: true, length: { maximum: 100 }
  validates :email,    format: { with: VALID_EMAIL_REGEX },
                       uniqueness: { case_sensitive: false }
  validates :username, presence: true, length: { maximum: 50 },
                       uniqueness: { case_sensitive: false, scope: :organisation },
                       format: { with: VALID_USERNAME_REGEXP }
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
