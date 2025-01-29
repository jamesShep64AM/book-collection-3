require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'validations' do
    it 'is valid with all attributes' do
      book = Book.new(title: 'test',author: 'test', price: 9.99, published_date: Date.today)
      expect(book).to be_valid
    end

    it 'is invalid without a title' do
      book = Book.new(author: 'test', price: 9.99, published_date: Date.today)
      expect(book).not_to be_valid
      expect(book.errors[:title]).to include("can't be blank")
    end
    
    it "is invalid without an author" do
      book = Book.new(title: "Test Title", price: 9.99, published_date: Date.today)
      expect(book).not_to be_valid
    end
  
    it "is invalid without a price" do
      book = Book.new(title: "Test Title", author: "Test Author", published_date: Date.today)
      expect(book).not_to be_valid
    end
  
    it "is invalid without a published date" do
      book = Book.new(title: "Test Title", author: "Test Author", price: 9.99)
      expect(book).not_to be_valid
    end

    # New tests for invalid price
    it "is invalid with a negative price" do
      book = Book.new(title: "Test Title", author: "Test Author", price: -5, published_date: Date.today)
      expect(book).not_to be_valid
      expect(book.errors[:price]).to include("must be greater than or equal to 0")
    end

    it "is invalid with a non-numeric price" do
      book = Book.new(title: "Test Title", author: "Test Author", price: "free", published_date: Date.today)
      expect(book).not_to be_valid
      expect(book.errors[:price]).to include("is not a number")
    end

    # New tests for invalid published_date
    it "is invalid with an empty published date" do
      book = Book.new(title: "Test Title", author: "Test Author", price: 9.99, published_date: nil)
      expect(book).not_to be_valid
      expect(book.errors[:published_date]).to include("can't be blank")
    end
  end
end
