require 'selenium-webdriver'
require_relative '../utils'

describe "Google's Search Functionality" do
  include Utils

  before(:each) do
    @driver = Selenium::WebDriver.for(browser_type, browser_options)
    driver.manage.window.resize_to(1280, 720)
    driver.get(site_url)
  end

  after(:each) do
    driver.quit
  end

  it 'can find search results' do
    try_for(5) { driver.find_element(:xpath, "//button//div[contains(text(),'Accept all')]").click }
    element = driver.find_element(:name, 'q')
    try_for(10) { element.send_keys 'Where am i' }
    element.submit
    try_for(10) { expect(@driver.title).to eql('Where am i - Google Search') }
  end
end
