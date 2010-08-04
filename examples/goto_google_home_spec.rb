require File.dirname(__FILE__) + '/helper'

feature "Google" do
  scenario 'goto google home page and search ruby' do
    visit 'http://google.com'
  end
end
