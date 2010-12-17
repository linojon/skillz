Feature: User signs in

The authentication process should allow users to signin and signout and should persist a UserSession

  Scenario: Clicking the Sign In button
    Given I am on the home page
    And I am not signed in
    When I follow "sign in"
    Then I should be on the signin page
    And I should see "Sign in"
  
  Scenario: Signing in from the Sign in Page
    Given there is a user "jonathan@example.com"
    When I sign in as "jonathan@example.com"
    #And show me the page
    Then there should be a session
    And the user should be "jonathan@example.com"

  Scenario: The "I am signed in as" method
    Given I am signed in as "jonathan@example.com"
    Then there should be a session
    And the user should be "jonathan@example.com"
  
  Scenario: Signing Out
    Given I am signed in as "jonathan@example.com"
    When I sign out
    Then there should not be a session
  
  Scenario: Bad password
    Given there is a user "jonathan@example.com"
    And I am on the signin page
    When I fill in "Email" with "jonathan@linowes.com"
    And I fill in "Password" with "wrong"
    And I press "Sign in"
    Then I should be on the signin page
    And there should not be a session
    And I should see "Email or password was entered incorrectly" within the flashbar area

  Scenario: Unknown user
    Given I am on the signin page
    When I fill in "Email" with "wrong@linowes.com"
    And I fill in "Password" with "secret"
    And I press "Sign in"
    Then I should be on the signin page
    And there should not be a session
    And I should see "Email or password was entered incorrectly" within the flashbar area
      
    