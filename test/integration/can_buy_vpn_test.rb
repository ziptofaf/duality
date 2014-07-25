require 'test_helper'

class CanBuyVpnTest < ActionDispatch::IntegrationTest
test "buy a vpn" do
	visit "/logout"
        visit "/login"
        assert page.has_content?('Sign in'), "Invalid content on the page!"
        fill_in('session_email', :with=> "genius@genius.com")
        fill_in('session_password', :with=> "secret")
        click_button 'Sign in'
        assert current_path == root_path, "not moved to main page after a successful login"
        assert page.has_content?('My account'), "features available after loggin in didn't appear"
        visit "/store"
        #assert page.has_content?('<td>'), "no vpn to buy available in the store"
        visit "store/1"
        assert page.has_content?('test_if_details_show'), "details aren't showed!"
	assert page.has_content?('Pro VPN'), "incorrect title!"
	click_link "Buy!"
	assert page.has_content?('Choose contract length'), "didn't redirect to a correct website"
	choose "2 weeks"
	#select "russia", :from => 'Location'
	click_button "Buy VPN account"
	assert page.has_content?('Your account has been created!'), "invalid flash message"
	visit "/profile/payments"
	assert page.has_content?('Pro VPN'), "entry not added to purchase history"
        end

end
