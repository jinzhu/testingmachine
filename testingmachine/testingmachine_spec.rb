require 'helper'

feature 'Testing Machine' do
  scenario 'should run' do
    TM::Configuration.tags = nil
    TM::Configuration.names = nil
    assert TM.should_run?(nil, nil)
    assert TM.should_run?('hello', nil)

    TM::Configuration.tags = ['tagA']
    TM::Configuration.names = nil
    assert !TM.should_run?(nil, nil)
    assert TM.should_run?('tagA', nil)
    assert !TM.should_run?('tagB', nil)

    TM::Configuration.tags = nil
    TM::Configuration.names = 'nameA'
    assert !TM.should_run?(nil, nil)
    assert TM.should_run?(nil, 'nameA')
    assert !TM.should_run?(nil, 'nameB')
  end
end
