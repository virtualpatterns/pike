Given /^I am testing the application$/ do
  step 'I have an empty test database'
  step 'I am viewing "/"'
  step 'I should see "Logon with Google"'
end

And /^I am logged on as the demo user$/ do
  step 'I should see "Tap here to logon as the demo user"'
  step 'I click "here"'
  step 'I wait 2 seconds'
end

When /^I change the date from (yesterday|today|tomorrow) to (yesterday|today|tomorrow)?$/ do |from, to|

  case from
    when 'yesterday'
      from = Date.today - 1
    when 'today'
      from = Date.today
    when 'tomorrow'
      from = Date.today + 1
  end

  case to
    when 'yesterday'
      to = Date.today - 1
    when 'today'
      to = Date.today
    when 'tomorrow'
      to = Date.today + 1
  end

  step "I click \"#{from.strftime(Pike::Application.configure.format.date)}\""

  if from.month != to.month
    step "I click \"#{to.strftime('%b')}\""
  end

  step "I click \"#{to.day}\""

end

And /^I create the (first )?project "([^"]*)"$/ do |first, project|

  step 'I click "More ..."'
  step 'I click "Projects"'

  if first
    step 'I should see "You haven\'t created any projects."'
    step 'I click "here"'
  else
    step "I should not see \"#{project}\""
    step 'I click "Add"'
  end

  step "I fill in the \"Name\" field with \"#{project}\" and I press enter"
  step 'I click "Done"'
  step "I should see \"#{project}\""
  step 'I click "Back"'
  step 'I click "Back"'

end

When /^I change the name of project "([^"]*)" to "([^"]*)"$/ do |from_project, to_project|

  step 'I click "More ..."'
  step 'I click "Projects"'
  step "I click \"#{from_project}\""
  step "I fill in the \"Name\" field with \"#{to_project}\" and I press enter"
  step 'I click "Done"'
  step "I should see \"#{to_project}\""
  step 'I click "Back"'
  step 'I click "Back"'

end

Given /^I add the project property "([^"]*)"$/ do |property|

  step 'I click "More ..."'
  step 'I click "Projects"'
  step 'I click "Add"'
  step 'I click "Add Property"'
  step "I fill in the \"Name\" field with \"#{property}\" and I press enter"
  step 'I click "Done"'
  step "I should see \"#{property}\""
  step 'I click "Back"'
  step 'I click "Back"'
  step 'I click "Back"'
  step 'I wait 2 seconds'

end

And /^I create the (first )?activity "([^"]*)"$/ do |first, activity|

  step 'I click "More ..."'
  step 'I click "Activities"'

  if first
    step 'I should see "You haven\'t created any activities."'
    step 'I click "here"'
  else
    step "I should not see \"#{activity}\""
    step 'I click "Add"'
  end

  step "I fill in the \"Name\" field with \"#{activity}\" and I press enter"
  step 'I click "Done"'
  step "I should see \"#{activity}\""
  step 'I click "Back"'
  step 'I click "Back"'

end

When /^I change the name of activity "([^"]*)" to "([^"]*)"$/ do |from_activity, to_activity|

  step 'I click "More ..."'
  step 'I click "Activities"'
  step "I click \"#{from_activity}\""
  step "I fill in the \"Name\" field with \"#{to_activity}\" and I press enter"
  step 'I click "Done"'
  step "I should see \"#{to_activity}\""
  step 'I click "Back"'
  step 'I click "Back"'

end

And /^I create the (first )?task with project "([^"]*)" and activity "([^"]*)"$/ do |first, project, activity|

  if first
    step 'I should see "You haven\'t created any tasks."'
    step 'I click "here"'
  else
    step 'I click "Add"'
  end

  step 'I click "tap for a project"'
  step "I click \"#{project}\""
  step 'I click "tap for an activity"'
  step "I click \"#{activity}\""
  step 'I click "Other"'
  step 'I click "Liked"'
  step 'I click "Done"'
  step "I should see \"#{project}\""
  step "I should see \"#{activity}\""

end
