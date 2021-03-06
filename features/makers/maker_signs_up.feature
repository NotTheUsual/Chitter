Feature: Maker signs up
  In order to use Chitter
  As a Maker
  I want to sign up to the service

  Scenario: (getting from the homepage)
    Given I am on the homepage
    When I follow "Sign Up"
    Then I should be on the sign up page

  Scenario: from the sign up page
    Given I am on the sign up page
    When I fill in the following:
      | name          | Enrique Comba Riepenhausen |
      | username      | ecomba                     |
      | email         | ecomba@makersacademy.com   |
      | password      | s3cr3t                     |
      | confirmation  | s3cr3t                     |
    And I press "Sign Up"
    Then there should be 1 Maker
    And I should see "Welcome, Enrique Comba Riepenhausen"
    And the first Maker's email should be "ecomba@makersacademy.com"
    And the first Maker's username should be "ecomba"

  Scenario: with a password that doesn't match
    Given I am on the sign up page
    When I fill in the following:
      | name          | Enrique Comba Riepenhausen |
      | username      | ecomba                     |
      | email         | ecomba@makersacademy.com   |
      | password      | s3cr3t                     |
      | confirmation  | wrong                      |
    And I press "Sign Up"
    Then there should be 0 Makers
    And I should be on the sign up page
    And I should see "Password does not match the confirmation"

  Scenario: with a username that's already taken
    Given I am on the sign up page
    And I am already signed up
    When I fill in the following:
      | name          | Enrique  Riepenhausen     |
      | username      | ecomba                    |
      | email         | enrique@makersacademy.com |
      | password      | s3cr3t                    |
      | confirmation  | s3cr3t                    |
    And I press "Sign Up"
    Then there should be 1 Maker
    And I should be on the sign up page
    And I should see "This username is already taken"

  Scenario: with an email address that's already taken
    Given I am on the sign up page
    And I am already signed up
    When I fill in the following:
      | name          | Enrique  Riepenhausen    |
      | username      | enrique                  |
      | email         | ecomba@makersacademy.com |
      | password      | s3cr3t                   |
      | confirmation  | s3cr3t                   |
    And I press "Sign Up"
    Then there should be 1 Maker
    And I should be on the sign up page
    And I should see "This email address is already taken"


