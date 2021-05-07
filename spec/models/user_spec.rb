require 'rails_helper'

RSpec.describe User, type: :model do

  it "Validate if email is entered" do
    user = User.new(name: "Jo", email: nil, password_digest: "password")
    result = user.save
    expect(result).to be(false)
  end

  it "Validates if password matches password confirmation" do
    user = User.new(name: "Jo", email: "1@1.com", password: "password", password_confirmation: "password")
    result = user.save
    expect(result).to be(true)
  end

  it "Validates if password does not match password confirmation" do
    user = User.new(name: "Jo", email: "1@1.com", password: "password", password_confirmation: "not password")
    result = user.save
    expect(result).to be(false)
  end

  it "Validates if password is present" do
    user = User.new(name: "Jo", email: "1@1.com", password: nil, password_confirmation: "password")
    result = user.save
    expect(result).to be(false)
  end

  it "Validates that the password will fail if not minimum six characters" do
    user = User.new(name: "David", email: "test@test.com", password_digest: "asdf")
    result = user.save
    expect(result).to be(false)
  end

  it "Validates that the password will succeed if minimum six characters" do
    user = User.new(name: "David", email: "test@test.com", password_digest: "moreThanSix")
    result = user.save
    expect(result).to be(true)
  end

  it "Validates if email is unique" do
    user = User.create(name: "Jo", email: "TEST@TEST.com", password: "password", password_confirmation: "password")

    other_user = User.new(name: "David", email: "test@test.com", password: "password2", password_confirmation: "password2")
    result = other_user.save
    expect(result).to be(false)
  end

end

describe '.authenticate_with_credentials' do
  
  it "return user object if email/password matches the database" do
    user = User.new(name: "John", email: "test@test.com", password: "password")
    user.save
    result = User.authenticate_with_credentials("test@test.com", "password")
    expect(result).not_to eq(nil)
  end

  it "return user object if email is entered with extra spaces at the start and end" do
    user = User.new(name: "John", email: "test@test.com", password: "password")
    user.save
    result = User.authenticate_with_credentials(" test@test.com ", "password")
    expect(result.class).to eq(User)
  end

  it "return nil if email/password does not match database" do
    user = User.new(name: "John", email: "test@test.com", password: "password")
    user.save
    result = User.authenticate_with_credentials("something@else.com", "not password")
    expect(result).to eq(nil)
  end

end
