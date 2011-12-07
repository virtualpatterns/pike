Feature: About Functionality

  Background:
    Given I am testing the application
    And I am logged on as a guest

  Scenario: View the about page
    Given I click "More ..."
    And I click "About"
    Then I should see "Available on GitHub"
