require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

module WithinHelpers
  def with_scope(locator)
    locator ? within(locator) { yield } : yield
  end
end
World(WithinHelpers)

Given(/^I peep$/) do
  visit '/peeps/new'
  fill_in("message", with: "just setting up my chttr")
  click_button("Peep")
end

Given(/^I peep again$/) do
  visit '/peeps/new'
  fill_in("message", with: "Second message!")
  click_button("Peep")
end

Given(/^I reply to that peep$/) do
  first('.date').click
  fill_in("message", with: "First reply!")
  click_button("Reply")
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

Then(/^I should see the full time the peep was created$/) do
  t = Time.now
	text = t.strftime "%-l:%M %p - %-d %b %Y"
  if page.respond_to? :should
    page.should have_content(text)
  else
    assert page.has_content?(text)
  end
end

# From https://github.com/makandra/spreewald
Then /^I should see in this order:?$/ do |text|
  if text.is_a?(String)
    lines = text.split(/\n/)
  else
    lines = text.raw.flatten
  end
  lines = lines.collect { |line| line.gsub(/\s+/, ' ')}.collect(&:strip).reject(&:empty?)
  pattern = lines.collect(&Regexp.method(:quote)).join('.*?')
  pattern = Regexp.compile(pattern)
  page.text.gsub(/\s+/, ' ').should =~ pattern
end