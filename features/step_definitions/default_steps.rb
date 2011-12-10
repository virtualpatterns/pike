Given /^I have an empty test database$/ do
  Pike::Application.drop_database!
end

Given /^I have created a guest user$/ do
  Pike::User.create_guest_user!
end

Given /^I am viewing "([^"]*)"$/ do |url|
  visit(url)
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
  sleep 1
end

When /^I (start|stop) the task with project "([^"]*)" and activity "([^"]*)"$/ do |start_or_stop, project, activity|
  find("li.item[project='#{project}'][activity='#{activity}'] a.start").click
  sleep 1
end

Then /^the task with project "([^"]*)" and activity "([^"]*)" should (not )?be started$/ do |project, activity, negative|
  selector = "li.item.started[project='#{project}'][activity='#{activity}']"
  unless negative
    page.should have_css(selector)
  else
    page.should_not have_css(selector)
  end
end

When /^I edit the task with project "([^"]*)" and activity "([^"]*)"$/ do |project, activity|
  find("li.item[project='#{project}'][activity='#{activity}'] a.edit").click
  sleep 1
end

When /^I fill in the "([^"]*)" field with "([^"]*)"( and I press enter)?$/ do |field, value, enter|
  fill_in(field, :with => value)
  if enter
    find_field(field).native.send_key(:enter)
    sleep 1
  end
end

Then /^show me the page$/ do
  save_and_open_page
end

When /^I wait (\d+) seconds$/ do |interval|
  sleep(interval.to_f)
end
