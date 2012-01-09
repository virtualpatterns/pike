Feature: Logoff Functionality

  Background:
    Given I am testing the application
    And I logon as the first demo user

  Scenario: Logoff the user from the More ... page
    And I click "More ..."
    And I click "Logoff"
    Then I should see "Logon with Google"
