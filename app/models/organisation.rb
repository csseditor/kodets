class Organisation < ActiveRecord::Base
  has_many :teachers
  has_many :students

  before_create :set_ref
  before_create :check_population

  validates :name,        presence: true, on: :update
  validates :email,       presence: true
  validates :description, length: { maximum: 140 }
  validates :url,         allow_blank: true, format: URI.regexp

  def to_param
    ref.to_s
  end

  def users
    Teacher.where(organisation_id: self.id) +
    Student.where(organisation_id: self.id)
  end

  private

  def set_ref
    begin
      ref = rand(999_999).to_s.center(6, rand(9).to_s).to_i
    end while Organisation.exists?(ref: ref)
    self.ref = ref
  end

  def check_population
    # change when max_users is added to Orgs
    unless true
      raise Exceptions::OrganisationOverPopulated, 'You have surpassed your maximum amount of users'
    end
  end
end
