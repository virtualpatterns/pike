Feature: About Functionality

  Background:
    Given I am testing the application
    And I logon as the first demo user

  Scenario: View the about page
    Given I click "More ..."
    And I click "About"
    Then I should see "Source code available at"
