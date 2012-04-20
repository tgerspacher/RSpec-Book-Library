require 'spec_helper'

describe Book do
	book :each do
		@book = Book.new "Title", "Author", :category
	end

	describe "#new" do
		it "takes three parameters and returns a Book object" do
			@book.should be_an_instance_of Book
		end
	end
end

