Feature: Project Functionality

  Background:
    Given I am testing the application
    And I am logged on as the demo user

  Scenario: Delete the first project
    Given I create the first project "Project 1"
    And I click "More ..."
    And I click "Projects"
    And I click "Project 1"
    And I click "Delete"
    And I click "Yes"
    Then I should not see "Project 1"

  Scenario: Delete an in-use project
    Given I create the first project "Project 1"
    And I create the first activity "Activity 1"
    And I create the first task with project "Project 1" and activity "Activity 1"
    And I click "More ..."
    And I click "Projects"
    And I click "Project 1"
    And I click "Delete"
    And I click "Yes"
    Then I should see "The selected project cannot be deleted."
    Then I click "Close"
