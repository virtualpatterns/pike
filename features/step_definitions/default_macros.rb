Given /^I am testing the application$/ do
  step 'I have an empty test database'
  step 'I have created a guest user'
  step 'I am viewing "/"'
end

And /^I am logged on as a guest$/ do
  step 'I click "Logon with Google"'
  step 'I should see "You are logged on as ..."'
  step 'I should see "Guest"'
  step 'I click "Continue"'
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

And /^I create the (first )?task with project "([^"]*)" and activity "([^"]*)"$/ do |first, project, activity|

  if first
    step 'I should see "You haven\'t created any tasks."'
    step 'I click "here"'
  else
    step 'I click "Add"'
  end

  step 'I click "(select a project)"'
  step "I click \"#{project}\""
  step 'I click "(select an activity)"'
  step "I click \"#{activity}\""
  step 'I click "Other"'
  step 'I click "Liked"'
  step 'I click "Done"'
  step "I should see \"#{project}\""
  step "I should see \"#{activity}\""
end
