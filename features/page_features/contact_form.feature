Feature: Contact form
  In order to contact the company
  As a visitor
  I want to send a message via the contact form
  
  Scenario: Go to contact form
    Given I am on the home page
    And I follow "contact"
    Then I should see "Contact Us"
    
  Scenario: Fill in and send contact form
    Given I am on the new contact form page
    When I fill in "Name" with "Example"
    And I fill in "Email" with "example@example.com"
    And I fill in "Message" with "Hello, this is my message."
    And I press "Send"
    Then I should be on the home page
    And I should see "Message sent! Thank you for contacting us." within the flashbar area
    And "info@example.com" should receive an email with subject "SkillZillion contact form"
    When "info@skillzillion.com" opens the email
    Then they should see /Hello, this is my message/ in the email body
    And they should see the email delivered from "Example <example@example.com>"
    
