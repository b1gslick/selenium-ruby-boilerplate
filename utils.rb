module Utils
  def try_for(timeout)
    start_time = Time.now
    last_error = nil
    until (duration = Time.now - start_time) > timeout
      begin
        yield
        last_error = nil
        return true
      rescue StandardError => e
        last_error = e
      end
      sleep 0.1
    end

    raise "Timeout after #{duration.to_i} seconds with error: #{last_error}." if last_error

    raise "Timeout after #{duration.to_i} seconds."
  end

  def browser_options
    the_browser_type = browser_type.to_s
    case the_browser_type
    when 'chrome'
      the_chrome_options = Selenium::WebDriver::Chrome::Options.new
      the_chrome_options.add_argument('--headless') if ENV['BROWSER_HEADLESS'] == 'true'
      { options: the_chrome_options }
    when 'firefox'
      the_firefox_options = Selenium::WebDriver::Firefox::Options.new
      the_firefox_options.add_argument('--headless') if ENV['BROWSER_HEADLESS'] == 'true'
      { options: the_firefox_options }
    when the_browser_type == 'edge'
      the_edge_options = Selenium::WebDriver::Edge::Options.new
      the_edge_options.detach = true
      the_edge_options.add_argument('--headless') if ENV['BROWSER_HEADLESS'] == 'true'
      { options: the_edge_options }
    else
      {}
    end
  end

  def browser_type
    if ENV['BROWSER'] && !ENV['BROWSER'].empty?
      ENV['BROWSER'].downcase.to_sym
    else
      :chrome
    end
  end

  def site_url(default = 'https://www.google.com/ncr')
    ENV['BASE_URL'] || default
  end

  def driver
    @driver
  end

  def browser
    @driver
  end

  def visit(path)
    driver.get(site_url + path)
  end
end
