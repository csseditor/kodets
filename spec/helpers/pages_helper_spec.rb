RSpec.describe PagesHelper, type: :helper do
  describe '#header_class' do
    it 'returns CSS classes based on the current controller and action' do
      expect(helper.header_class).to eq 'navbar navbar-inverse normal'

      allow(controller).to receive(:controller_name) { 'pages' }
      allow(controller).to receive(:action_name)     { 'home' }

      expect(helper.header_class).to eq 'navbar navbar-inverse hero'
    end
  end
end
