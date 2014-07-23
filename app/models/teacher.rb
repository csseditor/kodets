class Teacher < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :organisation
  after_create :create_organisation

  validates :username,  presence: true, on: :update
  validates :email,     presence: true

  private

  def create_organisation
    @org = self.build_organisation(email: self.email)
    @org.save
  end
end
