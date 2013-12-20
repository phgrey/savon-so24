require 'spec_helper'

describe Savon::So24::Model::Person do
  it 'should get all and a scpecified person' do
    cmps = Savon::So24::Model::Person.all
    expect(cmps.class.name).to eq 'Array'
    cmps = cmps[0][:id]
    cmp=Savon::So24::Model::Person.find cmps
    expect(cmp.class.name).to eq 'Hash'
  end

  it 'should export a person' do
    usr = create(:user)
    id = usr.export.to_i
    expect(id).to be > 0
  end
end