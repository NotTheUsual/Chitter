Feature: Someone views an individual peep
  In order to see an individual peep
  As a visitor
  I want to click on a link in the main stream

  Scenario: from the homepage
    Given I am already signed up
    And I am already signed in
    And I peep
    And I am on the homepage
    When I follow the first date link
    # Then I should be on the page for that peep
    And I should see "just setting up my chttr"
    And I should see the full time the peep was created