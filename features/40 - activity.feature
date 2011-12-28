Feature: Activity Functionality

  Background:
    Given I am testing the application
    And I am logged on as the demo user

  Scenario: Delete the first activity
    Given I create the first activity "Activity 1"
    And I click "More ..."
    And I click "Activities"
    And I click "Activity 1"
    And I click "Delete"
    And I click "Yes"
    Then I should not see "Activity 1"

  Scenario: Delete an in-use activity
    Given I create the first project "Project 1"
    And I create the first activity "Activity 1"
    And I create the first task with project "Project 1" and activity "Activity 1"
    And I click "More ..."
    And I click "Activities"
    And I click "Activity 1"
    And I click "Delete"
    And I click "Yes"
    Then I should see "The selected activity cannot be deleted."
    Then I click "Close"
