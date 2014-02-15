Feature: Maker signs in
  In order to use Chitter
  As a Maker
  I want to sign in

  Scenario: (getting from the homepage)
    Given I am on the homepage
    When I follow "Sign In"
    Then I should be on the sign in page

  Scenario: with correct credentials
    Given I am on the sign in page
    And I am already signed up
    When I fill in the following:
      | username | ecomba |
      | password | s3cr3t |
    And I press "Sign In"
    Then I should be on the homepage
    And I should see "Welcome, Enrique Comba Riepenhausen"

  Scenario: with incorrect credentials
    Given I am on the sign in page
    And I am already signed up
    When I fill in the following:
      | username | ecomba |
      | password | wrong3 |
    And I press "Sign In"
    Then I should be on the sign in page
    And I should see "The email or password are incorrect"
    And I should not see "Welcome, Enrique Comba Riepenhausen"
