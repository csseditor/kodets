class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #before_save :add_organisation_ref

  belongs_to :organisation

  private

  def add_organisation_ref
    self.organisation_ref = Organisation.find(self.id).ref
  end
end
