require 'helper'

feature "Google" do
  scenario 'goto google home page and search some keyword',:tag => :javascript do
    visit '/'
    within "form" do
      fill_in "q",:with => @keyword
      find(".lsb").click
    end
    hello.must_equal false
  end
end
