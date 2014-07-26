RSpec.describe Teacher, type: :model do
  it { should have_one(:organisation) }

  it { should validate_presence_of(:username).on(:create) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:first_name).on(:create) }
  it { should validate_presence_of(:last_name).on(:create) }

  it 'should create a new Organisation after creation' do
    teacher = create(:teacher)
    expect(teacher.organisation.email).to eq teacher.email
  end
end
