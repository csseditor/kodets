RSpec.describe Teacher, type: :model do
  it { should belong_to(:organisation) }

  it { should validate_presence_of(:username).on(:create) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:first_name).on(:update) }
  it { should validate_presence_of(:last_name).on(:update) }
  it { should ensure_inclusion_of(:title).in_array(%w(Mr. Mrs. Miss Ms Dr. Prof.)) }

  it 'should create a new Organisation after creation' do
    teacher = create(:teacher)
    expect(teacher.organisation.email).to eq teacher.email
  end
end
