require 'helper'

feature 'parse/plain_text.rb' do
	scenario 'should parse plain_text.table correctly' do
		file = 'plain_text_test'

		login_table = TM::Parse::PlainText[file, 'post a article > login to admin page']
		login_table.size.must_equal 2
		login_table[0].username.must_equal 'jinzhu'
		login_table[0].message.must_equal  /login successful/
		login_table[1].password.must_equal 'wrong_password'

		save_as_draft_table = TM::Parse::PlainText[file, 'post a article > save as draft']
		save_as_draft_table.size.must_equal 4
		save_as_draft_table[0].owner.must_equal true
	end
end
