class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :organisation

  validates :name,     presence: true, length: { maximum: 50 }
  validates :username, presence: true, uniqueness: { case_sensitive: false,
                                                     scope: :organisation,
                                                     message: 'must be unique' }
  validates :organisation_id, presence: true

  def teacher?
    teacher
  end

  def has_completed?(lesson)
    @progress = Progress.where(lesson_id: lesson.id,
                               lesson_type: lesson.class.name,
                               user_id: id).present?
  end
end
