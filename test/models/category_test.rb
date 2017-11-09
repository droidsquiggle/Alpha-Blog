require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  def setup
    # THIS WILL NEVER HIT THE DEVELOPMENT DATABASE THIS WILL ONLY TOUCH TEST DB
    @category = Category.new(name: "sports")
  end
  
  test "category should be valid" do
    assert @category.valid?
  end
  
  test "name should be present" do
    @category.name = " "
    assert_not @category.valid?
  end
  
  test "name should be unique" do
    #this hits the test data base
    @category.save
    category2 = Category.new(name: "sports")
    
    #this should not be valid because we already have a category with name sports
    assert_not category2.valid?
  end
  
  test "name should not be too long" do
    @category.name = "a" * 26
    
    assert_not @category.valid?
  end
  
  test "name should not be too short" do
    @category.name = "a"
    
    assert_not @category.valid?
  end
end
