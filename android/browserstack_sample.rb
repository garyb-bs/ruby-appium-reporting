require 'rubygems'
require 'appium_lib'
require 'selenium-webdriver'

caps = {}

# Set URL of the application under test
caps['app'] = 'bs://becbf5e0b19608e053765a0f3e30a48778128068'

# Specify device and os_version for testing
caps['deviceName'] = 'Samsung Galaxy S23'
caps['os_version'] = '13.0'

# Set other BrowserStack capabilities
caps['project'] = 'First Ruby project'
caps['build'] = 'browserstack-build-1'
caps['name'] = 'single_test-3'

#Set the platform name
caps['platformName'] = 'android'

# Initialize the remote Webdriver using BrowserStack remote URL
# and desired capabilities defined above
appium_driver = Appium::Driver.new({
	'caps' => caps,
	'appium_lib' => {
		:server_url => "http://#{ENV["BROWSERSTACK_USERNAME"]}:#{ENV["BROWSERSTACK_ACCESS_KEY"]}@hub-cloud.browserstack.com/wd/hub"
	}}, true)
driver = appium_driver.start_driver

# Test case for the BrowserStack sample Android app. 
# If you have uploaded your app, update the test case here. 
wait = Selenium::WebDriver::Wait.new(:timeout => 30)
wait.until { driver.find_element(:accessibility_id, "Search Wikipedia").displayed? }
element = driver.find_element(:accessibility_id, "Search Wikipedia")
element.click

wait.until { driver.find_element(:id, "org.wikipedia.alpha:id/search_src_text").displayed? }
search_box = driver.find_element(:id, "org.wikipedia.alpha:id/search_src_text")
search_box.send_keys("BrowserStack")
sleep 5

results = driver.find_elements(:class, "android.widget.TextView")
if results.count > 0
	puts "Found results - Test Passed"
else
	puts "No results found - Test Failed"
end

# Invoke driver.quit() after the test is done to indicate that the test is completed.
driver.quit
