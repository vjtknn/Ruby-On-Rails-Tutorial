require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example User", email: "user@example.com",
                    password: "foobar", password_confirmation: "foobar")
   end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "  "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = " "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 41
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 51 + "@example.com"
    assert_not @user.valid?
  end

  test "email validation should accept valid adressess" do
    valid_adressess = %w[user@.example.com USER@doo.COM A_US-FR@user.uk
                      first.last@pocztex.org pudelek@plotek.pl]
    valid_adressess.each do |valid_adress|
    @user.email = valid_adress
    assert @user.valid?, "#{valid_adress.inspect} should be valid"
      end
  end

  test "email validation shlould reject invalid adressess" do
    invalid_adresses = %w[user@example,com user_at_foo.org user.name@example.
                        foo@bar_baz.biz foo@bar+baz.com]
    invalid_adresses.each do |invalid_adress|
      @user.email = invalid_adress
      assert_not @user.valid?, "#{invalid_adress.inspect} should be invalid"
    end
  end

  test "email should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email adressess should be save as lower-case" do
    mixed_case_email = "FoObAr@EExAmPlE.Com"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 3
    assert_not @user.valid?
  end

  test "password should have minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
end
