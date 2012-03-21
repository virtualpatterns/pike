Feature: Friend Functionality

  Background:
    Given I am testing the application
    And I create all demo users

  Scenario: View the initial friend list
    And I logon as the first demo user
    When I click "More ..."
    And I click "Friends"
    Then I should see "You have no introductions and no friends."
    Then I quit

  Scenario: Add the first friend
    And I logon as the first demo user
    When I click "More ..."
    And I click "Friends"
    And I click "here"
    And I fill in the "User" field with "second@pike.virtualpatterns.com" and I change focus
    And I click "Send"
    And I click "OK"
    Then I should see "You have no introductions and no friends."
    Then I quit

  Scenario: See the first introduction
    And I logon as the first demo user
    When I add the first friend "second@pike.virtualpatterns.com"
    And I logoff
    And I logon as the second demo user
    Then I should see "1 introduction(s) pending acceptance"
    And I should see "first@pike.virtualpatterns.com"
    When I click "More ..."
    And I click "Friends"
    Then I should not see "You have no introductions and no friends."
    And I should see "first@pike.virtualpatterns.com"
    Then I quit

  Scenario: Accept the first introduction
    And I logon as the first demo user
    When I add the first friend "second@pike.virtualpatterns.com"
    And I logoff
    And I logon as the second demo user
    Then I should see "1 introduction(s) pending acceptance"
    And I should see "first@pike.virtualpatterns.com"
    When I click "More ..."
    And I click "Friends"
    And I click "first@pike.virtualpatterns.com"
    And I click "Accept"
    And I click "OK"
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
    Then I quit

  Scenario: Ignore the first introduction
    And I logon as the first demo user
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
    Then I quit

  Scenario: Remove the first friend
    And I logon as the first demo user
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
    Then I quit

  Scenario: Share the first project
    And I create all demo friendships
    And I logon as the first demo user
    And I create the first shared project "Project 1"
    And I logoff
    And I process all actions
    And I logon as the second demo user
    Then I should see the project "Project 1"
    Then I quit

  Scenario: Rename the first project
    And I create all demo friendships
    And I logon as the first demo user
    And I create the first shared project "Project 1"
    And I logoff
    And I process all actions
    And I logon as the second demo user
    Then I should see the project "Project 1"
    When I logoff
    And I logon as the first demo user
    And I change the name of project "Project 1" to "Project 2"
    And I logoff
    And I process all actions
    And I logon as the second demo user
    Then I should see the project "Project 2"
    Then I should not see the project "Project 1"
    Then I quit

  Scenario: Unshare the first project
    And I create all demo friendships
    And I logon as the first demo user
    And I create the first shared project "Project 1"
    And I logoff
    And I process all actions
    And I logon as the second demo user
    Then I should see the project "Project 1"
    When I logoff
    And I logon as the first demo user
    And I do not share the project "Project 1"
    And I logoff
    And I process all actions
    And I logon as the second demo user
    Then I should not see the project "Project 1"
    Then I quit

  Scenario: Delete the first project
    And I create all demo friendships
    And I logon as the first demo user
    And I create the first shared project "Project 1"
    And I logoff
    And I process all actions
    And I logon as the second demo user
    Then I should see the project "Project 1"
    When I logoff
    And I logon as the first demo user
    And I delete the project "Project 1"
    And I logoff
    And I process all actions
    And I logon as the second demo user
    Then I should not see the project "Project 1"
    Then I quit

  Scenario: Share the first activity
    And I create all demo friendships
    And I logon as the first demo user
    And I create the first shared activity "Activity 1"
    And I logoff
    And I process all actions
    And I logon as the second demo user
    Then I should see the activity "Activity 1"
    Then I quit

  Scenario: Rename the first activity
    And I create all demo friendships
    And I logon as the first demo user
    And I create the first shared activity "Activity 1"
    And I logoff
    And I process all actions
    And I logon as the second demo user
    Then I should see the activity "Activity 1"
    When I logoff
    And I logon as the first demo user
    And I change the name of activity "Activity 1" to "Activity 2"
    And I logoff
    And I process all actions
    And I logon as the second demo user
    Then I should see the activity "Activity 2"
    Then I should not see the activity "Activity 1"
    Then I quit

  Scenario: Unshare the first activity
    And I create all demo friendships
    And I logon as the first demo user
    And I create the first shared activity "Activity 1"
    And I logoff
    And I process all actions
    And I logon as the second demo user
    Then I should see the activity "Activity 1"
    When I logoff
    And I logon as the first demo user
    And I do not share the activity "Activity 1"
    And I logoff
    And I process all actions
    And I logon as the second demo user
    Then I should not see the activity "Activity 1"
    Then I quit

  Scenario: Delete the first activity
    And I create all demo friendships
    And I logon as the first demo user
    And I create the first shared activity "Activity 1"
    And I logoff
    And I process all actions
    And I logon as the second demo user
    Then I should see the activity "Activity 1"
    When I logoff
    And I logon as the first demo user
    And I delete the activity "Activity 1"
    And I logoff
    And I process all actions
    And I logon as the second demo user
    Then I should not see the activity "Activity 1"
    Then I quit
