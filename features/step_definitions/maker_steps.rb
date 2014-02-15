require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

module WithinHelpers
  def with_scope(locator)
    locator ? within(locator) { yield } : yield
  end
end
World(WithinHelpers)

Given(/^I am already signed up$/) do
  Maker.create(name: "Enrique Comba Riepenhausen", username: "ecomba", email: "ecomba@makersacademy.com", password: "s3cr3t", password_confirmation: "s3cr3t")
end

Given(/^I am already signed in$/) do
  visit '/sessions/new'
  fill_in 'username', with: "ecomba"
  fill_in 'password', with: "s3cr3t"
  click_button 'Sign In'
end

Then /^there should be (\d+) Maker(?:|s+)$/ do |quantity|
  expect(Maker.count).to eq(quantity.to_i)
end

Then(/^the first Maker's email should be "(.*?)"$/) do |user_email|
  expect(Maker.first.email).to eq("ecomba@makersacademy.com")
end

Then(/^the first Maker's username should be "(.*?)"$/) do |arg1|
  expect(Maker.first.username).to eq("ecomba")
end