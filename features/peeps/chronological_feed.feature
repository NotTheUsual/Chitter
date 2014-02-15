Feature: Viewing the main feed
  In order to see what people have to say
  As a Maker
  I want to see all peeps in chronological order

  Scenario: when logged in
    Given I am already signed up
    And I am already signed in
    And I peep
    And I peep again
    Then I should see in this order:
      | Second message!             |
      | just setting up my chttr    |