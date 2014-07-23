RSpec.describe ApplicationHelper, type: :helper do
  describe '#full_title' do
    it 'constructs a HTML-safe String for a page title' do
      expect(helper.full_title('')).to eq 'Kodets'
      expect(helper.full_title('', 'Kodets-2')).to eq 'Kodets-2'

      expect(helper.full_title('About')).to eq 'About | Kodets'
      expect(helper.full_title('About', 'Kodets-2')).to eq 'About | Kodets-2'

      expect(helper.full_title('<a>Tuts</a>')).to eq '<a>Tuts</a> | Kodets'
    end
  end

  describe '#pluralise' do
    it 'returns an Array instead of a String like #pluralize would' do
      expect(helper.pluralise(1, 'cat').join(' ')).to eq pluralize(1, 'cat')
      expect(helper.pluralise(2, 'cat').join(' ')).to eq pluralize(2, 'cat')
    end
  end
end
