RSpec.describe Student, type: :model do
  it { should belong_to(:organisation) }

  it { should validate_presence_of(:name).on(:update) }
end
