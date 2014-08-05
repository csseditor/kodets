class Organisation < ActiveRecord::Base
  has_many :users, dependent: :destroy
  has_many :courses, dependent: :destroy

  before_create :set_ref

  validates :name,        presence: true, on: :update
  validates :email,       presence: true
  validates :description, length: { maximum: 140 }
  validates :url,         allow_blank: true, format: URI.regexp
  validates :max_users,   presence: true

  def to_param
    ref.to_s
  end

  private

  def set_ref
    begin
      ref = rand(999_999).to_s.center(6, rand(9).to_s).to_i
    end while Organisation.exists?(ref: ref)
    self.ref = ref
  end
end
