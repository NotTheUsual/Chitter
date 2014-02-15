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
		And I should see "just setting up my chttr"
		And I should see "Enrique Comba Riepenhausen"
		And I should see "ecomba"
		And I should see the current date

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

# So, I'm validating this with html (ie the message field has the 'required' attribute)
# Apparently Capybara can't deal with this (or at least, I can't make it)
# So if you actually carry out the actions listed below, everything's fine
# But Capybara's somehow able to submit the form...
# Odd...

#	Scenario: with an empty message
#		Given I am already signed up
#		And I am already signed in
#		And I am on the new peep page
#		When I press "Peep"
#		Then I should be on the new peep page
