class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :organisation
  has_many :progresses

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
                               user_id: id)
    @progress.present? && @progress.first.has_passed
  end

  def progress_in_track(track)
    items = track.items

    completed_items = []
    if items.count == 0
      0
    else
      items.each do |item|
        completed_items.push(item) if self.has_completed?(item)
      end
      (completed_items.count.round(1) / items.count.round(2) * 100).round(0)
    end
  end
end
