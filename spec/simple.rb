require 'selenium-webdriver'

describe "Google's Search Functionality" do
  it 'can find search results' do
    @driver.navigate.to 'https://www.google.com/ncr'
    element = @driver.find_element(:name, 'q')
    element.send_keys 'Where am i'
    element.submit
    sleep 5
    expect(@driver.title).to eql('Google')
  end
end
