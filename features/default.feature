Feature: Default Page

  Scenario: View the default page
    Given I am viewing "/"
    Then I should see "Logon with Google"
