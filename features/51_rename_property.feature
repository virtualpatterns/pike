Feature: Rename Property Functionality

  Background:
    Given I am testing the application
    And I logon as the first demo user

  Scenario: Rename a project property
    Given I create the first project "Project 1"
    And I add the project property "Property 1"
    And I click "More ..."
    And I click "Rename Property"
    And I fill in the "From" field with "Property 1" and I change focus
    And I fill in the "To" field with "Property 2" and I change focus
    And I click "Done"
    And I click "Yes"
    And I click "Projects"
    And I click "Project 1"
    Then I should see "Property 2"
    And I should not see "Property 1"

  Scenario: Rename an activity property
    Given I create the first activity "Activity 1"
    And I add the activity property "Property 1"
    And I click "More ..."
    And I click "Rename Property"
    And I fill in the "From" field with "Property 1" and I change focus
    And I fill in the "To" field with "Property 2" and I change focus
    And I click "Done"
    And I click "Yes"
    And I click "Activities"
    And I click "Activity 1"
    Then I should see "Property 2"
    And I should not see "Property 1"

  Scenario: Rename a task property
    Given I create the first project "Project 1"
    And I create the first activity "Activity 1"
    And I create the first task with project "Project 1" and activity "Activity 1"
    And I add the task property "Property 1"
    And I click "More ..."
    And I click "Rename Property"
    And I fill in the "From" field with "Property 1" and I change focus
    And I fill in the "To" field with "Property 2" and I change focus
    And I click "Done"
    And I click "Yes"
    And I click "Back"
    And I edit the task with project "Project 1" and activity "Activity 1"
    Then I should see "Property 2"
    And I should not see "Property 1"
