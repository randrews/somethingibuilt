require 'spec_helper'

describe User do
  it "should allow a user with no email" do
    expect(create(:user).valid?).to be_true
  end
end
