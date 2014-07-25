class Teacher < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :organisation
  after_create :create_organisation

  validates :username,   presence: true, on: :create
  validates :email,      presence: true
  validates :first_name, presence: true, on: :create
  validates :last_name,  presence: true, on: :create

  def full_name
    if self.first_name && self.last_name
      first_name.capitalize + ' ' + last_name.capitalize
    else
      'Teacher'
    end
  end

  def titlised_name
    if self.title && self.last_name
      self.title.capitalize + ' ' + self.last_name.capitalize
    end
  end

  private

  def create_organisation
    build_organisation(email: email).save
  end
end
