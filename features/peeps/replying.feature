Feature: Maker replies to a peep
	In order to start a conversation
	As a maker
	I want to reply to a peep from another maker

	Scenario: From the individual peep page
		Given I am already signed up
		And I am already signed in
		And I peep
		And I follow the first date link
		When I fill in the following:
			| message | Cool peep! |
		And I press "Reply"
		Then I should see "just setting up my chttr"
		And I should see "Cool peep!"