Feature: User password

  In order to maintain privacy of my account
  As a user
  I want to change or reset my password
  
  Scenario: Reset password request
    Given there is a user "example@example.com"
    And I am on the signin page
    When I follow "Can't access your account?"
    Then I should be on the new password reset page
    When I fill in "Email" with "example@example.com"
    And press "Reset my password"
    Then I should be on the home page
    And I should see "Instructions to reset your password have been emailed to you. Please check your email." within the flashbar area
    And "example@example.com" should receive an email with subject "Password Reset Instructions"
    
  
  Scenario: Reset password from email
    Given there is a user "example@example.com"
    And I am on the new password reset page
    When I fill in "Email" with "example@example.com"
    And press "Reset my password"
    Then I should receive an email with subject "Password Reset Instructions"
    When I open the email
    And I click the first link in the email 
    Then I should see "Change My Password"
    When I fill in "Password" with "newsecret"
    And I fill in "Confirm password" with "newsecret"
    And press "Update my password and log me in"
    Then there should be a session
    And the user should be "example@example.com"
    And I should see "Password successfully updated" within the flashbar area
    
     
  
    
  
