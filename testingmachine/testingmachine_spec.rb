require 'helper'

feature 'Testing Machine' do
  scenario 'should run' do
    TM::Configuration.types = nil
    TM::Configuration.names = nil
    assert TM.should_run?(nil, nil)
    assert TM.should_run?('hello', nil)

    TM::Configuration.types = ['typeA']
    TM::Configuration.names = nil
    assert !TM.should_run?(nil, nil)
    assert TM.should_run?('typeA', nil)
    assert !TM.should_run?('typeB', nil)

    TM::Configuration.types = nil
    TM::Configuration.names = 'nameA'
    assert !TM.should_run?(nil, nil)
    assert TM.should_run?(nil, 'nameA')
    assert !TM.should_run?(nil, 'nameB')
  end
end
