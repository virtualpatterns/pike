Feature: Weekly Summary Functionality

  Scenario: View the weekly summary
    Given I am testing the application
    And I am logged on as a guest
    When I create the first project "Project 1"
    And I create the first activity "Activity 1"
    And I create the project "Project 2"
    And I create the activity "Activity 2"
    And I create the project "Project 3"
    And I create the activity "Activity 3"
    And I create the first task with project "Project 1" and activity "Activity 1"
    And I create the task with project "Project 2" and activity "Activity 2"
    And I create the task with project "Project 3" and activity "Activity 3"
    And I edit the task with project "Project 1" and activity "Activity 1"
    And I fill in the "Duration" field with "1h" and I press enter
    And I click "Done"
    And I edit the task with project "Project 2" and activity "Activity 2"
    And I fill in the "Duration" field with "2h" and I press enter
    And I click "Done"
    And I edit the task with project "Project 3" and activity "Activity 3"
    And I fill in the "Duration" field with "3h" and I press enter
    And I click "Done"
    And I click "More ..."
    And I click "Weekly Summary"
    Then I should see "Project 1"
    And I should see "Activity 1"
    And I should see "1 hr"
    And I should see "Project 2"
    And I should see "Activity 2"
    And I should see "2 hrs"
    And I should see "Project 3"
    And I should see "Activity 3"
    And I should see "3 hrs"
