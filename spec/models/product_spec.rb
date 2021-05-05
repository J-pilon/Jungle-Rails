require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    context 'check for' do
      before :each do
        @category = Category.new(name: "Furniture")
      end
    
      it "to return truen when all fields are filled" do
        product = @category.products.new(name: "waky waving inflatable tube guy", price: 500, quantity: 10, category_id: 1)
        result = product.save
        expect(result).to be(true)
      end

      it "to have error message when no name" do
        product = @category.products.new(name: nil, price: 500, quantity: 10, category_id: 1)
        product.save
        expect(product.errors.full_messages[0]).to eq("Name can't be blank")
      end

      it "to have error message when no price" do
        product = @category.products.new(name: "waky waving inflatable tube guy", price: nil, quantity: 10, category_id: 1)
        product.save
        expect(product.errors.full_messages[2]).to eq("Price can't be blank")
      end

      it "to have error message when no quantity" do
        product = @category.products.new(name: "waky waving inflatable tube guy", price: 500, quantity: nil, category_id: 1)
        product.save
        expect(product.errors.full_messages[0]).to eq("Quantity can't be blank")
      end
    end
  end
end
