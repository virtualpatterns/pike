Feature: Activity Functionality

  Background:
    Given I am testing the application
    And I am logged on as the demo user

  Scenario: Add a property to activities
    Given I click "More ..."
    And I click "Activities"
    And I click "here"
    And I fill in the "Name" field with "Activity 1" and I press enter
    And I click "Add Property"
    And I fill in the "Name" field with "Property 1" and I press enter
    And I fill in the "Value" field with "Value 1" and I press enter
    And I click "Done"
    And I click "Done"
    Then I should see "Activity 1"
    When I click "Activity 1"
    Then I should see "Property 1"
    And I should see "Value 1"
    When I click "Back"
    And I click "Add"
    Then I should see "Property 1"
    And I should see "(no value)"

  Scenario: Delete a property from activities
    Given I add the activity property "Property 1"
    And I click "More ..."
    And I click "Activities"
    And I click "Add"
    And I click "(no value)"
    And I click "Remove Property"
    And I click "Yes"
    Then I should not see "Property 1"
    And I should not see "(no value)"
    When I click "Back"
    And I click "Add"
    Then I should not see "Property 1"
    And I should not see "(no value)"

  Scenario: Delete the first activity
    Given I create the first activity "Activity 1"
    And I click "More ..."
    And I click "Activities"
    And I click "Activity 1"
    And I click "Delete"
    And I click "Yes"
    Then I should not see "Activity 1"

  Scenario: Delete an in-use activity
    Given I create the first project "Activity 1"
    And I create the first activity "Activity 1"
    And I create the first task with project "Activity 1" and activity "Activity 1"
    And I click "More ..."
    And I click "Activities"
    And I click "Activity 1"
    And I click "Delete"
    And I click "Yes"
    Then I should see "The selected activity cannot be deleted."
    Then I click "Close"
