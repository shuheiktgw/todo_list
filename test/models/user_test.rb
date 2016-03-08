require 'test_helper'

class UserTest < ActiveSupport::TestCase
	def setup
		@user = User.new(email: "example@test.com", password: "password", password_confirmation: "password")
	end

	test "shoud be valid" do
		assert @user.valid?
	end

	test "email should be present" do
		@user.email = " "
		assert_not @user.valid?
	end

	test "email should not be too long" do
		@user.email = "a" * 500
		assert_not @user.valid?
	end

	test "email validation should accept valid emails" do
		valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
		valid_addresses.each do |valid_address|
			@user.email = valid_address
			assert @user.valid?, "#{valid_address} should have been valid, but..."
		end
	end

	test "email validation should reject invalid addresses" do
		invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.]
		invalid_addresses.each do |invalid_address|
			@user.email = invalid_address
			assert_not @user.valid?, "#{invalid_address} should have been invalid, but..."
		end
	end

end
