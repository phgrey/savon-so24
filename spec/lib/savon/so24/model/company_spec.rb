require 'spec_helper'

describe Savon::So24::Model::Company do
  it 'should get all and a scpecified company' do
    cmps = Savon::So24::Model::Company.all
    expect(cmps.class.name).to eq 'Array'
    cmps = cmps[0][:id]
    cmp=Savon::So24::Model::Company.find cmps
    expect(cmp.class.name).to eq 'Hash'
  end

  it 'should export a company' do
    cmp = create(:user).company
    id = cmp.export.to_i
    expect(id).to be > 0
  end
end