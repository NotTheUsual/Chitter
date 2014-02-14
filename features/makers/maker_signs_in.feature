Feature: Maker signs in
  In order to use Chitter
  As a Maker
  I want to sign in

  Scenario: (getting from the homepage)
    Given I am on the homepage
    When I follow "Sign In"
    Then I should be on the sign in page