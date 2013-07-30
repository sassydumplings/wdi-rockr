require 'spec_helper'

describe "Homepage", :js => true do
  before do
    visit root_path
  end

  it "shows form to add venues" do
    click_button "New Venue"

    expect(page).to have_css('form#new_venue')
  end

  it "shows form to add concerts" do
    click_button "New Concert"

    expect(page).to have_css('form#new_concert')
  end

  describe "venues form" do
    it "updates list of concerts on the homepage" do
      click_button "New Venue"

      fill_in "Name", :with => "Yoshi's"
      click_button "Save Venue"

      expect(page.find('#concerts')).to have_content("Yoshi's")
    end

    it "updates list of venues for concerts" do
      click_button "New Venue"

      fill_in "Name", :with => "The Fillmore"
      click_button "Save Venue"

      click_button "New Concert"

      expect(page.find('#new_concert').find_field('Venue')).to have_content("The Fillmore")
    end
  end

  describe "concerts form" do
    it "updates list of concerts on the homepage" do
      click_button "New Concert"

      fill_in "Venue", :with => "The Slowdown"
      fill_in "Artist Name", :with => "The Mynabirds"
      fill_in "Performing On", :with => Time.now.tomorrow
      click_button "Save Concert"

      expect(page.find('#concerts')).to have_content("The Mynabirds")
    end
  end
end