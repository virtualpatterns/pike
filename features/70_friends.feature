Feature: Friend Functionality

  Background:
    Given I am testing the application
    And I create all demo users

  Scenario: View the initial friend list
    Given I logon as the first demo user
    When I click "More ..."
    And I click "Friends"
    Then I should see "You have no introductions and no friends."

  Scenario: Add the first friend
    Given I logon as the first demo user
    When I click "More ..."
    And I click "Friends"
    And I click "here"
    And I fill in the "User" field with "second@pike.virtualpatterns.com" and I change focus
    And I click "Send"
    Then I should see "You have no introductions and no friends."

  Scenario: See the first introduction
    Given I logon as the first demo user
    When I add the first friend "second@pike.virtualpatterns.com"
    And I logoff
    And I logon as the second demo user
    Then I should see "1 introduction(s) pending acceptance"
    And I should see "first@pike.virtualpatterns.com"
    When I click "More ..."
    And I click "Friends"
    Then I should not see "You have no introductions and no friends."
    And I should see "first@pike.virtualpatterns.com"

  Scenario: Accept the first introduction
    Given I logon as the first demo user
    When I add the first friend "second@pike.virtualpatterns.com"
    And I logoff
    And I logon as the second demo user
    Then I should see "1 introduction(s) pending acceptance"
    And I should see "first@pike.virtualpatterns.com"
    When I click "More ..."
    And I click "Friends"
    And I click "first@pike.virtualpatterns.com"
    And I click "Accept"
    Then I should not see "You have no introductions and no friends."
    And I should see "first@pike.virtualpatterns.com"
    When I click "Back"
    And I click "Back"
    And I logoff
    And I logon as the first demo user
    And I click "More ..."
    And I click "Friends"
    Then I should not see "You have no introductions and no friends."
    And I should see "second@pike.virtualpatterns.com"

  Scenario: Ignore the first introduction
    Given I logon as the first demo user
    When I add the first friend "second@pike.virtualpatterns.com"
    And I logoff
    And I logon as the second demo user
    Then I should see "1 introduction(s) pending acceptance"
    And I should see "first@pike.virtualpatterns.com"
    When I click "More ..."
    And I click "Friends"
    And I click "first@pike.virtualpatterns.com"
    And I click "Ignore"
    And I click "Yes"
    Then I should see "You have no introductions and no friends."
    And I should not see "first@pike.virtualpatterns.com"
    When I click "Back"
    And I click "Back"
    And I logoff
    And I logon as the first demo user
    And I click "More ..."
    And I click "Friends"
    Then I should see "You have no introductions and no friends."
    And I should not see "second@pike.virtualpatterns.com"

  Scenario: Remove the first friend
    Given I logon as the first demo user
    When I add the first friend "second@pike.virtualpatterns.com"
    And I logoff
    And I logon as the second demo user
    And I accept the introduction from "first@pike.virtualpatterns.com"
    And I logoff
    And I logon as the first demo user
    And I click "More ..."
    And I click "Friends"
    And I click "second@pike.virtualpatterns.com"
    And I click "Remove Friend"
    And I click "Yes"
    Then I should see "You have no introductions and no friends."
    And I should not see "second@pike.virtualpatterns.com"
