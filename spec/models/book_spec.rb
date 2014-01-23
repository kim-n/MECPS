require 'spec_helper'

describe Book do
  it "creates valid book" do
    FactoryGirl.create(:book).should be_valid
  end
  
  let(:incomplete_book) {book = FactoryGirl.build(:incomplete_book)}
    
  describe "title" do
    it "is required" do 
      FactoryGirl.build(:book, title: nil).should_not be_valid
      expect(incomplete_book).to have(1).error_on(:title)
    end
  end
  
  describe "author" do
    it "is required" do 
      FactoryGirl.build(:book, author: nil).should_not be_valid
      expect(incomplete_book).to have(1).error_on(:author)
    end
  end
  
  describe "image" do
    it "is required" do 
      FactoryGirl.build(:book, image: nil).should_not be_valid
      expect(incomplete_book).to have(1).error_on(:image)
    end
  end

end
