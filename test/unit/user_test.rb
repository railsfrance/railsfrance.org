require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = Factory.build :user
  end

  test 'should be valid' do
    assert @user.valid?
  end

  test 'should not be valid with bad username' do
    @user.username = nil
    assert @user.invalid?
    tmp_user = Factory.create :user
    @user.username = tmp_user.username
    assert @user.invalid?
  end

  test 'should not be valid with bad github' do
    @user.github = (0..40).map{ ('a'..'z').to_a[rand(26)] }.join
    assert @user.invalid?
    tmp_user = Factory.create :user
    @user.github = tmp_user.github
    assert @user.invalid?
  end
  
  test 'should not be valid with bad twitter' do
    @user.twitter = (0..15).map{ ('a'..'z').to_a[rand(26)] }.join
    assert @user.invalid?
    tmp_user = Factory.create :user
    @user.twitter = tmp_user.twitter
    assert @user.invalid?
  end

  test 'should be localized after validation' do
    @user.save
    assert @user.latitude
    assert @user.longitude
  end

  test 'should accept website without http prefix' do
    @user.website = 'www.example.com'
    assert @user.valid?
    assert_equal 'http://www.example.com', @user.website
  end

  test 'should not http prefix an empty website' do
    @user.website = ''
    assert @user.valid?
    assert_equal '', @user.website
  end

  test 'should not double http prefix website' do
    @user.website = 'http://www.example.com'
    assert @user.valid?
    assert_equal 'http://www.example.com', @user.website
  end
end
