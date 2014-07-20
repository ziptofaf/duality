require 'test_helper'
 

class CanLoginTest < ActionDispatch::IntegrationTest
test "login and access profile" do
	visit "/login"
	assert page.has_content?('Sign in'), "Invalid content on the page!"
	fill_in('session_email', :with=> "genius@genius.com")
	fill_in('session_password', :with=> "secret")
	click_button 'Sign in'
	assert current_path == root_path, "not moved to main page after a successful login"
	assert page.has_content?('My account'), "features available after loggin in didn't appear"
	visit "/profile/change"
	assert page.has_content?("Enter your current password"), "page that allows to change password didn't appear"
	end
end
