require 'rails_helper'

RSpec.describe "Books", type: :request do
    describe "POST /books" do
        let(:valid_attributes) do
          { title: "Test Book", author: "John Doe", price: 19.99, published_date: "2023-01-01" }
        end
        it "creates a book and shows success flash notice" do
            post books_path, params: {book:valid_attributes}
          expect(response).to redirect_to(books_path)
          follow_redirect!
          expect(response.body).to include("Book was successfully created")
        end
        context "with invalid parameters" do
          it "fails to create a book with blank title and shows error flash notice" do
            post books_path, params: { book: valid_attributes.merge(title: "") }
    
            expect(response).to render_template(:new)
            expect(response.body).to include("Title can&#39;t be blank")
          end
    
          it "fails to create a book with blank author and shows error flash notice" do
            post books_path, params: { book: valid_attributes.merge(author: "") }
    
            expect(response).to render_template(:new)
            expect(response.body).to include("Author can&#39;t be blank")
          end
    
          it "fails to create a book with blank price and shows error flash notice" do
            post books_path, params: { book: valid_attributes.merge(price: nil) }
    
            expect(response).to render_template(:new)
            expect(response.body).to include("Price can&#39;t be blank")
          end
    
          it "fails to create a book with blank published_date and shows error flash notice" do
            post books_path, params: { book: valid_attributes.merge(published_date: nil) }
    
            expect(response).to render_template(:new)
            expect(response.body).to include("Published date can&#39;t be blank")
          end
    
          it "fails to create a book with negative price and shows error flash notice" do
            post books_path, params: { book: valid_attributes.merge(price: -10) }
    
            expect(response).to render_template(:new)
            expect(response.body).to include("Price must be greater than or equal to 0")
          end
    
          it "fails to create a book with a non-numeric price and shows error flash notice" do
            post books_path, params: { book: valid_attributes.merge(price: "free") }
    
            expect(response).to render_template(:new)
            expect(response.body).to include("Price is not a number")
          end
        end
      end
    end