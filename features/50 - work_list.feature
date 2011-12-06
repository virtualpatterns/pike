Feature: Work List Functionality

  Background:
    Given I am testing the application
    And I am logged on as a guest

  Scenario: View the initial work list
    Then I should see "You haven't created any tasks."

  Scenario: View the initial project list
    Given I click "Add"
    And I click "(select a project)"
    Then I should see "You haven't created any projects."

  Scenario: View the initial activity list
    Given I click "Add"
    And I click "(select an activity)"
    Then I should see "You haven't created any activities."

  Scenario Outline: Create the first project
    Given I click "Add"
    And I click "(select a project)"
    And I click "<click>"
    And I fill in the "Name" field with "Project 1" and I press enter
    And I click "Done"
    Then I should see "Project 1"
    When I click "Project 1"
    Then I should see "Project 1"

    Scenarios: values for click
      | click |
      | here  |
      | Add   |

  Scenario Outline: Create the first activity
    Given I click "Add"
    And I click "(select an activity)"
    And I click "<click>"
    And I fill in the "Name" field with "Activity 1" and I press enter
    And I click "Done"
    Then I should see "Activity 1"
    When I click "Activity 1"
    Then I should see "Activity 1"

    Scenarios: values for click
      | click |
      | here  |
      | Add   |

  Scenario Outline: Create the first task
    Given I create the first project "Project 1"
    And I create the first activity "Activity 1"
    And I click "<click>"
    And I click "(select a project)"
    And I click "Project 1"
    And I click "(select an activity)"
    And I click "Activity 1"
    And I click "Done"
    Then I should see "Project 1"
    And I should see "Activity 1"

    Scenarios: values for click
      | click |
      | here  |
      | Add   |

  Scenario: Start/stop the first task
    Given I create the first project "Project 1"
    And I create the first activity "Activity 1"
    And I create the first task with project "Project 1" and activity "Activity 1"
    And I start the task with project "Project 1" and activity "Activity 1"
    Then the task with project "Project 1" and activity "Activity 1" should be started
    When I stop the task with project "Project 1" and activity "Activity 1"
    Then the task with project "Project 1" and activity "Activity 1" should not be started

  Scenario: Specify a duration for the first task
    Given I create the first project "Project 1"
    And I create the first activity "Activity 1"
    And I create the project "Project 2"
    And I create the activity "Activity 2"
    And I create the first task with project "Project 1" and activity "Activity 1"
    And I create the task with project "Project 2" and activity "Activity 2"
    And I edit the task with project "Project 1" and activity "Activity 1"
    And I fill in the "Duration" field with "1h 20m 5s" and I press enter
    And I click "Done"
    Then I should see "1 hr 20 min"
    When I edit the task with project "Project 2" and activity "Activity 2"
    And I fill in the "Duration" field with "2h 10m 10s" and I press enter
    And I click "Done"
    Then I should see "2 hrs 10 min"
    And I should see "3 hrs 30 min"

  Scenario: Clear the duration for the first task
    Given I create the first project "Project 1"
    And I create the first activity "Activity 1"
    And I create the first task with project "Project 1" and activity "Activity 1"
    And I edit the task with project "Project 1" and activity "Activity 1"
    And I fill in the "Duration" field with "1h 20m 5s" and I press enter
    And I click "Done"
    Then I should see "1 hr 20 min"
    When I edit the task with project "Project 1" and activity "Activity 1"
    And I fill in the "Duration" field with "" and I press enter
    And I click "Done"
    Then I should not see "1 hr 20 min"

  Scenario: Clear the duration for a started task
    Given I create the first project "Project 1"
    And I create the first activity "Activity 1"
    And I create the first task with project "Project 1" and activity "Activity 1"
    And I start the task with project "Project 1" and activity "Activity 1"
    Then the task with project "Project 1" and activity "Activity 1" should be started
    When I edit the task with project "Project 1" and activity "Activity 1"
    And I fill in the "Duration" field with "1h" and I press enter
    And I click "Done"
    Then I should see "1 hr"
    When I edit the task with project "Project 1" and activity "Activity 1"
    And I fill in the "Duration" field with "" and I press enter
    And I click "Done"
    Then the task with project "Project 1" and activity "Activity 1" should not be started

  Scenario: Change the project, activity, and category of the first task
    Given I create the first project "Project 1"
    And I create the first activity "Activity 1"
    And I create the project "Project 2"
    And I create the activity "Activity 2"
    And I create the first task with project "Project 1" and activity "Activity 1"
    Then I should see "Project 1"
    And I should see "Activity 1"
    When I edit the task with project "Project 1" and activity "Activity 1"
    And I click "Project 1"
    And I click "Project 2"
    And I click "Activity 1"
    And I click "Activity 2"
    And I click "Liked"
    And I click "Completed"
    And I click "Done"
    Then I should see "Project 2"
    And I should see "Activity 2"

  Scenario: Delete the first task
    Given I create the first project "Project 1"
    And I create the first activity "Activity 1"
    And I create the first task with project "Project 1" and activity "Activity 1"
    Then I should see "Project 1"
    And I should see "Activity 1"
    When I edit the task with project "Project 1" and activity "Activity 1"
    And I click "Delete"
    And I click "Yes"
    Then I should not see "Project 1"
    And I should not see "Activity 1"

  Scenario: Delete a started task
    Given I create the first project "Project 1"
    And I create the first activity "Activity 1"
    And I create the first task with project "Project 1" and activity "Activity 1"
    And I start the task with project "Project 1" and activity "Activity 1"
    Then the task with project "Project 1" and activity "Activity 1" should be started
    When I edit the task with project "Project 1" and activity "Activity 1"
    And I click "Delete"
    And I click "Yes"
    Then I should not see "Project 1"
    And I should not see "Activity 1"

  Scenario: Change the date to yesterday
    Given I change the date from today to yesterday

  Scenario: Change the date to tomorrow
    Given I change the date from today to tomorrow
    Then I should see "The selected date is invalid."