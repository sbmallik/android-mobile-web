require_relative "../spec/spec_helper"

class FrontPage
  attr_accessor :driver

  def initialize(driver)
    @driver = driver
  end

  def logo
    @driver.first_ele('header-home')
  end

  def nav_button
    @driver.first_ele('main-nav-btn')
  end

  def nav_hub
    @driver.first_ele('menu-nav-list')
  end

  def life_link
    @driver.first_ele('life')
  end

  def life_logo
    @driver.first_ele('header-life')
  end

  def lead_asset_link
    @driver.first_ele('lead-story')
  end

  def asset_header
    @driver.first_ele('story-header')
  end

end
