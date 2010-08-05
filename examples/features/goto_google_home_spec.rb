require File.dirname(__FILE__) + '/../helper'

feature "Google" do
  scenario 'goto google home page and search ruby',:type => :javascript do
    visit @url
  end
end
