require 'test_helper'

class CannotSeeSomeoneElseAccount < ActionDispatch::IntegrationTest
test "visit someones account" do
        test_account = prepare_special_account
        visit "/logout"
        visit "/login"
        assert page.has_content?('Sign in'), "Invalid content on the page!"
        fill_in('session_email', :with=> "genius@genius.com")
        fill_in('session_password', :with=> "secret")
        click_button 'Sign in'
        assert current_path == root_path, "not moved to main page after a successful login"
        assert page.has_content?('My account'), "features available after logging in didn't appear"
        #assert page.has_content?('<td>'), "no vpn to buy available in the store"
        visit "product_processors/vpn/details/#{test_account.id}"
        assert page.has_content?('Duality VPN'), "not redirected to the main website when accessing something that you really shouldnt be able to!!"
        end

test "visit my account" do
  test_account = prepare_own_account
  visit "/logout"
  visit "/login"
  assert page.has_content?('Sign in'), "Invalid content on the page!"
  fill_in('session_email', :with=> "genius@genius.com")
  fill_in('session_password', :with=> "secret")
  click_button 'Sign in'
  assert current_path == root_path, "not moved to main page after a successful login"
  assert page.has_content?('My account'), "features available after logging in didn't appear"
  visit "product_processors/vpn/details/#{test_account.id}"
  assert page.has_content?('shouldntsee'), "not being shown auth data of your own account"
  end

  def prepare_special_account
      account = Account.find_by login: "shouldntsee"
      user = User.find_by email: "idiot@idiot.com"
      account.update_attribute :user_id, user.id
      account.update_attribute :product_id, 1
      return account
  end

  def prepare_own_account
    account = Account.find_by login: "shouldntsee"
    user = User.find_by email: "genius@genius.com"
    account.update_attribute :user_id, user.id
    account.update_attribute :product_id, 1
    return account
  end

end
