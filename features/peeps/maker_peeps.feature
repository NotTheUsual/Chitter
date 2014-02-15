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


	Scenario: when logged out and on the new peep page
		Given I am on the new peep page
		And I am not signed in
		Then I should be on the sign in page
		And I should see "Please sign in to post a peep"

	Scenario: when logging in from the new peep page
		Given I am on the new peep page
		And I am already signed up
		And I am not signed in
		When I sign in
		Then I should be on the new peep page
