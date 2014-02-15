require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

module WithinHelpers
  def with_scope(locator)
    locator ? within(locator) { yield } : yield
  end
end
World(WithinHelpers)

Given(/^I tweet$/) do
  visit '/peeps/new'
  fill_in("message", with: "just setting up my chttr")
  click_button("Peep")
end

When(/^I follow the first date link$/) do
  first('.date').click
end

Then /^(?:|I )should see the current date(?: within "([^\"]*)")?$/ do |selector|
	t = Time.now
	text = t.strftime "%b %-d"
  with_scope(selector) do
    if page.respond_to? :should
      page.should have_content(text)
    else
      assert page.has_content?(text)
    end
  end
end

Then(/^I should see the time the tweet was created$/) do
  t = Time.now
	text = t.strftime "%-l:%M %p - %-d %b %Y"
  if page.respond_to? :should
    page.should have_content(text)
  else
    assert page.has_content?(text)
  end
end