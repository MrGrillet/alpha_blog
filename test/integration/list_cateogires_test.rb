require 'test_helper'

class CreateCategoriesListTest < ActionDispatch::IntegrationTest

def setup
	@category = Category.create(name: "Sports")
	@category2 = Category.create(name: "Programming")
	
end
	test "should show categories listing"
	get categories_path
	assert_template 'categories/index'
	assert_select "a[href=?]", category_path(@category), text: @category.name
	assert_select "a[href=?]", category_path(@category2), text: @category2.name

end
