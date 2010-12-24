Feature: Worker sign up
  In order to get started on the site
  As a visitor
  I want to "plant my flag"

  Scenario: Enter zipcode
    Given I am on the home page
    When I fill in "zipcode" with "02210"
    And I press "Skill me!"
    Then I should be on the Signup page
    And I should see a Google map centered on Boston with a bouncing marker
  
  Scenario: Sign up
    Given I am on the Sign Up page for zipcode "02210
    When I fill in "email" with "example@example.com"
    And press "Begin"
    Then I should be on the Enter Skills pages
    And there should be an unregistered user "example@example.com"
    And there should be a session 
    And the user should be "example@example.com"
    
  