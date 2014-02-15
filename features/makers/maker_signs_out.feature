Feature: Maker signs out
	In order to avoid others using my account
	As a Maker
	I want to log out

	Scenario: from the homepage
		Given I am already signed up
		And I am already signed in
		And I am on the homepage
		When I press "Sign Out"
		Then I should be on the homepage
		And I should see "Goodbye!"