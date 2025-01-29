require 'rails_helper'

RSpec.describe "Books", type: :request do
  describe "POST /books" do
    let(:valid_attributes) { { book: { title: "valid test" } } }
    let(:invalid_attributes) { { book: { title: "" } } }
    it "creates a book and shows success flash notice" do
        post books_path, params: valid_attributes

      expect(response).to redirect_to(books_path)
      follow_redirect!
      expect(response.body).to include("Book was successfully created")
    end

    it "fails to create a book with blank title and shows error flash notice" do
      post books_path, params: { book: invalid_attributes }

      expect(response).to render_template(:new)
      expect(response.body).to include("Title can&#39;t be blank")
    end
  end
end