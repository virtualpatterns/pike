Feature: Activity Functionality

  Background:
    Given I am testing the application
    And I logon as the first demo user

  Scenario: Add a property to activities
    And I click "More ..."
    And I click "Activities"
    And I click "here"
    And I fill in the "Name" field with "Activity 1" and I change focus
    And I click "Add Property"
    And I fill in the "Name" field with "Property 1" and I change focus
    And I fill in the "Value" field with "Value 1" and I change focus
    And I click "Done"
    And I click "Done"
    Then I should see "Activity 1"
    When I click "Activity 1"
    Then I should see "Property 1"
    And I should see "Value 1"
    When I click "Back"
    And I click "Add"
    Then I should see "Property 1"
    And I should see "tap to enter a value"
    Then I quit

  Scenario: Delete a property from activities
    And I add the activity property "Property 1"
    And I click "More ..."
    And I click "Activities"
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
    Then I quit

  Scenario: Delete the first activity
    And I create the first activity "Activity 1"
    And I click "More ..."
    And I click "Activities"
    And I click "Activity 1"
    And I click "Delete"
    And I click "Yes"
    Then I should not see "Activity 1"
    Then I quit

  Scenario: Delete an in-use activity
    And I create the first project "Project 1"
    And I create the first activity "Activity 1"
    And I create the first task with project "Project 1" and activity "Activity 1"
    And I click "More ..."
    And I click "Activities"
    And I click "Activity 1"
    And I click "Delete"
    And I click "Yes"
    Then I should see "The selected activity cannot be deleted."
    Then I click "Close"
    Then I quit
