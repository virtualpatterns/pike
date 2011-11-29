Feature: Logon Functionality

  @broken
  Scenario: View the logged on page
    Given I am viewing "/"
    When I click "Logon with Google"
    Then I should see "You are logged on as ..."
