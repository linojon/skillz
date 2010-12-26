Feature: User signs up

  In order to access the great features of this site
  As a potential user
  I want to sign up for an account

  Scenario: Clicking the Sign Up button
    Given I am on the home page
    When I follow "sign up"
    Then I should be on the signup page
    And I should see "Sign up"
  
  # Scenario: Registering from the Sign up Page
  #   Given I am on the signup page
  #   When I fill in "Email" with "example@example.com"
  #   And fill in "Password" with "secret"
  #   And fill in "Confirm Password" with "secret"
  #   And press "Sign up"
  #   Then I should be on the dashboard page
  #   And I should see "Thank you for signing up! You are now signed in." within the flashbar area
  #   And there should be a session
  #   And the user should be "example@example.com"
  #   And "example@example.com" should receive an email with subject "Welcome to SkillZillion"

