class Organisation < ActiveRecord::Base
  belongs_to :teacher

  before_create :set_ref

  validates :name, presence: true
  validates :email, presence: true
  validates :description, length: { maximum: 140 }
  validates :url, allow_blank: true, format: URI::regexp(%w(http https))

  private

  def set_ref
    begin
      ref = rand(999_999).to_s.center(6, rand(9).to_s).to_i
    end while Organisation.exists?(ref: ref)
    self.ref = ref
  end
end
