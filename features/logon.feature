Feature: Logon Functionality

  Scenario: View the logged on page
    Given I am viewing "/"
    When I click "Logon with Google"
    Then I should see "Sign in"
    When I fill in the "Email" field with "frank.ficnar@gmail.com"
    And I fill in the "Password" field with "*************"
    And I click "Sign in"
    Then I should see "You are logged on as ..."
    And I should see "frank.ficnar@gmail.com"
