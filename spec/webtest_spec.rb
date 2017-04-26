require_relative "spec_helper"

describe 'Android web', :web_demo do

  it 'run the first test' do 
    front_page = FrontPage.new @driver
    @selenium_driver.navigate.to('https://www.usatoday.com')
    expect(front_page.logo.displayed?).to be true
    expect(front_page.nav_button.displayed?).to be true
    front_page.nav_button.click
    wait_for { expect(front_page.nav_hub.displayed?).to be true }
    expect(front_page.life_link.displayed?).to be true
    front_page.life_link.click
    wait_for { expect(front_page.life_logo.displayed?).to be true }
    front_page.lead_asset_link.click
    wait_for { expect(front_page.asset_header.displayed?).to be true }
  end

end
