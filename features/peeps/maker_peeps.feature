Feature: Maker posts a message
	In order to let people know what I'm doing
	As a Maker
	I want to post a message to Chitter

	Scenario: when logged in
		Given I am already signed up
		And I am already signed in
		When I follow "New Peep"
		And I fill in the following:
			| message | just setting up my chttr |
		And I press "Peep"
		Then I should be on the homepage
		And I should see "Your peep has been posted!"

	Scenario: when logged out
		Given I am on the homepage
		And I am not signed in
		Then I should not see "New Peep"