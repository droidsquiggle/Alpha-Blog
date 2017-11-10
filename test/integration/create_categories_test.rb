require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = User.create(username: "jon", email: "jon@jon.com", password: "test", admin: true)
  end
  
  
  
  
  test "get new category form and create category" do
    # remember the password is hashed so we need to pass the password into the function in order to hash it
    sign_in_as(@user, "test")
    
    get new_category_path
    
    #test assertion that the user can goto the categorie / new page
    assert_template 'categories/new'
    
    # there should be a difference in category count of one
    assert_difference 'Category.count', 1 do
      # a post request to the categories path which gets directed to the create action
      post_via_redirect categories_path, category: {name: "sports"}
    end

    # after we are posting via redirect, after the post action, where do we send the user?
    assert_template 'categories/index'
    
    # make sure the cateogry name got created in the page we are goign to display 'categories/index'
    assert_match "sports", response.body
    
  end
  
  
  test "invalid category submission results in failure" do
    sign_in_as(@user, "test")
    
    get new_category_path
    
    assert_template 'categories/new'
    assert_no_difference 'Category.count' do
      post categories_path, category: {name: ""}
    end

    assert_template 'categories/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
end