class Teacher < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :organisation

  validates :username,   presence: true, on: :create
  validates :email,      presence: true
  validates :first_name, presence: true, on: :update
  validates :last_name,  presence: true, on: :update
  validates :title,      inclusion: { in: ['Mr.', 'Mrs.', 'Miss', 'Ms'] }

  def full_name
    if self.first_name && self.last_name
      first_name.capitalize + ' ' + last_name.capitalize
    else
      'Teacher'
    end
  end

  def titlised_name
    if self.title != '' && self.last_name
      self.title.capitalize + ' ' + self.last_name.capitalize
    else
      'Teacher'
    end
  end
end
