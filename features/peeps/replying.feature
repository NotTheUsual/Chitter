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
    And I should see the full time the peep was created

  Scenario: In the main feed
    Given I am already signed up
    And I am already signed in
    And I peep
    And I reply to that peep
    When I am on the homepage
    Then I should see "in reply to ecomba"

  Scenario: Viewing a reply
    Given I am already signed up
    And I am already signed in
    And I peep
    And I reply to that peep
    When I visit the page for that reply
    Then I should see "just setting up my chttr"
    
  Scenario: When logged out
    Given I am already signed up
    And I am already signed in
    And I peep
    And I sign out
    When I follow the first date link
    Then I should not see "Reply"