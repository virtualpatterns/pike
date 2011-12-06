Feature: Logoff Functionality

  Background:
    Given I am testing the application

  Scenario: Logoff the user from the default page
    Given I click "Logon with Google"
    Then I should see "You are logged on as ..."
    And I should see "Guest"
    When I click "Logoff"
    Then I should see "Logon with Google"

  Scenario: Logoff the user from the More ... page
    Given I am logged on as a guest
    And I click "More ..."
    And I click "Logoff"
    Then I should see "Logon with Google"
