require 'spec_helper'

describe "Library object" do

    before :all do
        lib_obj = [
            Book.new("JavaScript: The Good Parts", "Douglas Crockford", :development),
            Book.new("Designing with Web Standards", "Jeffrey Zeldman", :design),
            Book.new("Don't Make me Think", "Steve Krug", :usability),
            Book.new("JavaScript Patterns", "Stoyan Stefanov", :development),
            Book.new("Responsive Web Design", "Ethan Marcotte", :design)
        ]
        File.open "books.yml", "w" do |f|
            f.write YAML::dump lib_obj
        end
    end

    before :each do
        @lib = Library.new "books.yml"
    end

    describe "#new" do

        context "with no parameters" do
            it "has no books" do
                lib = Library.new
                lib.should have(0).books
            end
        end
        context "with a yaml file parameter" do
            it "has five books" do
                @lib.should have(5).books
                # Note: Alternatively could have done: lib.books.length.should == 5
            end
        end
    end

    it "returns all the books in a given category" do
        @lib.get_books_in_category(:development).length.should == 2
    end

    it "accepts new books" do
        @lib.add_book( Book.new("Designing for the Web", "Mark Boulton", :design) )
        @lib.get_book("Designing for the Web").should be_an_instance_of Book
    end

    it "saves the library" do
        books = @lib.books.map { |book| book.title }
        @lib.save
        lib2 = Library.new "books.yml"
        books2 = lib2.books.map { |book| book.title }
        books.should eql books2
    end

end