require 'spec_helper'

describe "Homepage", :js => true do
  before do
    visit root_path
  end

  it "shows form to add venues" do
    click_link "New Venue"

    expect(page).to have_css('form#new_venue')
  end

  it "shows form to add concerts" do
    click_link "New Concert"

    expect(page).to have_css('form#new_concert')
  end

  describe "venues form" do
    it "updates list of concerts on the homepage" do
      click_link "New Venue"

      fill_in "Name", :with => "Yoshi's"
      click_button "Create Venue"

      expect(page.find('#concerts')).to have_content("Yoshi's")
    end

    it "updates list of venues for concerts" do
      click_link "New Venue"

      fill_in "Name", :with => "The Fillmore"
      click_button "Create Venue"

      click_link "New Concert"

      expect(page.find('#new_concert').find_field('Venue')).to have_content("The Fillmore")
    end
  end

  describe "concerts form", :js => true do
    it "updates list of concerts on the homepage" do
      # Jane/Dwayne: Why isn't this working? The select menu for Venues is blank! :(

      # FactoryGirl.create(:venue, {name: "The Slowdown"})
      Venue.create!(name: "The Slowdown")

      click_link "New Concert"

      sleep 10

      fill_in "Artist name", :with => "The Mynabirds"

      click_button "Create Concert"

      expect(page.find('#concerts')).to have_content("The Mynabirds")
    end
  end
end