require 'capybara'
require 'capybara/dsl'
require 'capybara/poltergeist'
include Capybara::DSL

Capybara.current_driver = :poltergeist

page.visit("http://localhost:3000/jstest/jquery")
puts(page.text)