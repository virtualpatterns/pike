Feature: Project Functionality

  Background:
    Given I am testing the application
    And I am logged on as the first demo user

  Scenario: Add a property to projects
    Given I click "More ..."
    And I click "Projects"
    And I click "here"
    And I fill in the "Name" field with "Project 1" and I press enter
    And I click "Add Property"
    And I fill in the "Name" field with "Property 1" and I press enter
    And I fill in the "Value" field with "Value 1" and I press enter
    And I click "Done"
    And I click "Done"
    Then I should see "Project 1"
    When I click "Project 1"
    Then I should see "Property 1"
    And I should see "Value 1"
    When I click "Back"
    And I click "Add"
    Then I should see "Property 1"
    And I should see "tap to enter a value"

  Scenario: Delete a property from projects
    Given I add the project property "Property 1"
    And I click "More ..."
    And I click "Projects"
    And I click "Add"
    And I click "tap to enter a value"
    And I click "Remove Property"
    And I click "Yes"
    Then I should not see "Property 1"
    And I should not see "tap to enter a value"
    When I click "Back"
    And I click "Add"
    Then I should not see "Property 1"
    And I should not see "tap to enter a value"

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
