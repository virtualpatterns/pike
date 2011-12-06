Feature: Logon Functionality

  Scenario: View the logged on user
    Given I am testing the application
    And I click "Logon with Google"
    Then I should see "You are logged on as ..."
    And I should see "Guest"
