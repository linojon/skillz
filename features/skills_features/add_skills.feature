Feature: Define my skills
  In order to get started on the site
  As a visitor
  I want to define my skills

  Background:
    Given I am on the home page
    When I fill in "zipcode" with "02210"
    And I press "Skill Me!"
    And I fill in "email" with "example@example.com"
    And press "Begin"
    Then I should be on the Enter Skills pages
    
  # Temporary gui for selecting skills, just keyword input
  Scenario: Enter skills
    When I fill in "Skills keyword" with "carpentry"
    And press "Add"
    Then the skills list should include "carpentry"
    When I fill in "Skills keyword" with "juggling"
    And press "Add"
    Then the skills list should include "juggling"
  
  Scenario: Entering skills should update map markers
    When I fill in "Skills Keyword" with "carpentry"
    And press "Add"
    Then the Google map should update with 12 markers for other members with "carpentry" skills
    
  Scenario: Save skills
    When I fill in "Skills keyword" with "carpentry"
    And press "Add"
    And press "Save"
    Then user "example@example.com" should have the "carpentry" skill
    
    
