Feature:
  In order to populate the skills database
  As a site admin
  I want to browse and edit the skills records
  
  Background:
    Given I am signed in as an admin
    When I go to the "admin skills" page

  Scenario: Browse existing skills records
    Then I should see the "skills" tree view
    And I should see the following top level nodes in the "Skills" tree:
      | Banking |
      | Computer Software |
      | Healthcare Services |
    When I click on the "Healthcare Services" node
    Then I should see the following nodes under "Healthcare Services":
      | Registered Nurse |
    When I click on the "Registered Nurse" node
    Then I should see the following nodes under "Registered Nurse":
      | Blood drawing |
      

  Scenario: Add skill 
    Given the "Skills" tree has "Healthcare Services" / "Registered Nurse" nodes opened
    And "Registered Nurse" is currently selected
    When I follow "add skill"
    Then I should see the "Add Skill" form
    When I fill in "Skill name" with "interview patients"
    And press "Add"
    Then I should see the following nodes under "Registered Nurse":
      | Blood drawing |
      | Interview patients|
      
      
  