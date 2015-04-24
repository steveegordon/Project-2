require 'test_helper'

class UserTest < ActiveSupport::TestCase
    def setup
    @user = User.new(name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @user.valid?
  end

    test "name should be present" do
    @user.name = "     "
    assert_not @user.valid?
  end

  test "email should be present" do 
    @user.email = "    "
    assert_not @user.valid?
  end

  test "name should not be too long" do 
    @user.name = "a" * 21
    assert_not @user.valid?
  end

  test "email should not be too long" do 
    @user.email = "a" * 41 + "@example.com"
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do 
    valid_addresses = %w[user@example.com USER@gmail.com Tim_user@work.email.com Steve.Gordon@rails.io ann+bob@hotmail.jp]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
    assert @user.valid?, "#{valid_address.inspect} should be valid"
    
  end
end
  test "email validation should reject invalid addresses" do 
    invalid_addresses = %w[phil@example,com Abc.example.com user.name@example. foobar@hotmail+gmail.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
    assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
end
end

  test "email addresses should be unique" do 
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end
  test "password should have a minimum length" do 
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
    
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

end
  # test "the truth" do
  #   assert true
  # end

