require 'rails_helper'

RSpec.feature "Visitor clicks on a product", type: :feature, js: true do

  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They see the products details" do
    
    visit root_path

    first(".product").click_on('Details')

    expect(page).to have_text 'Quantity', count: 1    
    save_screenshot 'test_two_product_details.png'
  end
end
