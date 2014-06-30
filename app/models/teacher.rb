class Teacher < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :organisation
  after_create :create_organisation

  private

  def create_organisation
    @org = self.build_organisation(name: 'Test Name', email: self.email,
                                   description: 'Test Description',
                                   url: 'http://example.com')
    @org.save
  end
end
