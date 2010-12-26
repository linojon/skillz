Feature: Admin users
  In order to authorize users to use the site
  As the admin
  I want add and remove user accounts
  
  Background:
    Given there are users registered
  
  Scenario: Access denied
    Given I am not signed in
    When I go to the users page
    Then I should see "Access denied"
    And I should be on the home page

  Scenario: Access denied non-admins
    Given I am signed in
    When I go to the users page
    Then I should see "Access denied"
    And I should be on the dashboard page
  
  Scenario: List of users
    Given I am signed in as an admin
    When I go to the users page
    Then I should see "foo@example.com"
    And should see "bar@example.com"

  Scenario: Create a user
    Given I am signed in as an admin
    When I go to the users page
    And follow "Add a user"
    Then I should be on the new user page
    When I fill in "Email address" with "newuser@example.com"
    And fill in "Zipcode" with "03585"
    And fill in "Password" with "secret"
    And fill in "Confirm Password" with "secret"
    And press "Sign up"
    Then I should be on the users page
    And I should see "User successfully added"
    And I should see "newuser@example.com"
  
  Scenario: Delete a user
    Given I am signed in as an admin
    When I go to the users page
    When I follow "delete" on the row containing "foo@example.com"
    And I should see "User deleted"
    And I should not see "foo@example.com"
    
  
  Scenario: Make user admin
    Given I am signed in as an admin
    When I go to the users page
    And I follow "normal" on the row containing "foo@example.com"
    Then I should see "USER IS AN ADMIN"
    And I should see "ADMIN" on the row containing "foo@example.com"
  
  Scenario: Un-admin a user
    Given I am signed in as an admin
    When I go to the users page
    And I follow "normal" on the row containing "foo@example.com"
    Then I should see "USER IS AN ADMIN"
    When I sign out
    And I sign in as "foo@example.com"
    And I go to the users page
    When I follow "ADMIN" on the row containing "admin@example.com"
    Then I should see "normal" on the row containing "admin@example.com"
    
    
  