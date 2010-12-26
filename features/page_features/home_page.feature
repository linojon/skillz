Feature: Home page
  In order to get started on the site
  As a visitor
  I want to see a welcome screen and read info
  
  Scenario: Home page
    When I go to the home page
    Then I should see "Plant your flag"
    And I should see "Claim your skills"
    And I should see "Enter your zipcode"

  Scenario: Redirect to my dashboard when signed in
    Given I am signed in
    When I go to the home page
    Then I should be on the dashboard page

