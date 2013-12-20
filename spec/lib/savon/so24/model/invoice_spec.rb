require 'spec_helper'

describe Savon::So24::Model::Invoice do
  it 'should get all and a scpecified invoice' do
    cmps = Savon::So24::Model::Invoice.all
    expect(cmps.class.name).to eq 'Array'
    cmps = cmps[0][:order_id]
    cmp=Savon::So24::Model::Invoice.find cmps
    expect(cmp.class.name).to eq 'Hash'
  end

  it 'should export an invoice' do
    ord = create(:order)
    id = ord.export.to_i
    expect(id).to be > 0
  end
end