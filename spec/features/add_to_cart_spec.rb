require 'rails_helper'

RSpec.feature "Visitor clicks add to cart", type: :feature, js: true do

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

  scenario "quantity in 'My Cart(0)' is increased by one" do
    
    visit root_path

    expect(page).to have_text 'My Cart (0)'    

    first(".product").click_button('Add')

    expect(page).to have_text 'My Cart (1)'
        
    save_screenshot 'test_three_add_to_cart.png'
  end

  
end

