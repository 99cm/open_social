RSpec.describe Spree::SocialConfiguration, type: :model do
  it { is_expected.to respond_to(:path_prefix) }
  it { is_expected.to respond_to(:providers) }
end