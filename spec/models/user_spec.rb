require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  it { expect(user).to validate_presence_of(:email) }
  it { expect(user).to validate_uniqueness_of(:email).case_insensitive }
  it { expect(user).to validate_confirmation_of(:password) }
  it { expect(user).to allow_value("agc.rodrigo@gmail.com").for(:email) }
  it { expect(user).to be_valid }
end
