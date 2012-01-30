Given /^I have an empty test database$/ do
  Pike::Application.drop_database!
end

Given /^I process all actions$/ do
  Pike::System::Action.where_not_executed.each do |action|
    action.execute!
  end
end

Given /^I am viewing "([^"]*)"$/ do |url|
  visit("#{url}?event_error=false")
end

When /^I refresh the page$/ do
  visit(current_path)
end

Then /^I should (not )?see "([^"]*)"$/ do |negative, text|
  unless negative
    page.should have_content(text)
  else
    page.should_not have_content(text)
  end
end

When /^I click "([^"]*)"$/ do |text|
  click_on(text)
end

When /^I (start|stop) the task with project "([^"]*)" and activity "([^"]*)"$/ do |start_or_stop, project, activity|
  find("li.item[project='#{project}'][activity='#{activity}'] a.start").click
end

Then /^the task with project "([^"]*)" and activity "([^"]*)" should (not )?be started$/ do |project, activity, negative|
  selector = "li.item[project='#{project}'][activity='#{activity}']"
  page.should have_css(selector)
  selector = "li.item.started[project='#{project}'][activity='#{activity}']"
  unless negative
    page.should have_css(selector)
  else
    page.should_not have_css(selector)
  end
end

Then /^the duration for the task with project "([^"]*)" and activity "([^"]*)" should (not )?be blank$/ do |project, activity, negative|
  selector = "li.item[project='#{project}'][activity='#{activity}'] div.work"
  page.should have_css(selector)
  selector = "li.item[project='#{project}'][activity='#{activity}'] div.work.blank"
  unless negative
    page.should have_css(selector)
  else
    page.should_not have_css(selector)
  end
end

When /^I edit the task with project "([^"]*)" and activity "([^"]*)"$/ do |project, activity|
  find("li.item[project='#{project}'][activity='#{activity}'] a.edit").click
end

Then /^the task with project "([^"]*)" and activity "([^"]*)" should appear first$/ do |project, activity|
  selector = "li.item[project='#{project}'][activity='#{activity}'][index='0']"
  page.should have_css(selector)
end

When /^I fill in the "([^"]*)" field with "([^"]*)"( and I change focus)?$/ do |field, value, change_focus|
  fill_in(field, :with => value)
  if change_focus
    find('body').click
  end
end

When /^I (un)?check the "([^"]*)" field$/ do |uncheck, field|
  unless uncheck
    check(field)
  else
    uncheck(field)
  end
end

Then /^show me the page$/ do
  save_and_open_page
end

When /^I wait (\d+) seconds$/ do |interval|
  sleep(interval.to_f)
end
