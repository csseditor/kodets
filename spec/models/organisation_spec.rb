RSpec.describe Organisation, type: :model do
  let(:org) { create(:organisation) }

  it { should have_many(:teachers) }
  it { should have_many(:students) }
  it { should validate_presence_of(:name).on(:update) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:max_users) }
  it { should ensure_length_of(:description).is_at_most(140) }

  it do
    should allow_value(
      'http://rafalchmiel.com',
      'https://github.com/rafalchmiel'
    ).for(:url)
    should_not allow_value(
      'rafalchmiel.com',
      'www.github.com/rafalchmiel'
    ).for(:url)
  end

  it 'overrides #to_param to be its ref' do
    expect(org.to_param).to eq org.ref.to_s
  end

  it 'generates a 6-digit ref before creation' do
    expect(org.ref.to_s.length).to eq 6
  end
end
