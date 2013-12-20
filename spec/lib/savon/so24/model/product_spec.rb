require 'spec_helper'

describe Savon::So24::Model::Product do
  it 'should get all and a scpecified product' do
    cmps = Savon::So24::Model::Product.all
    expect(cmps.class.name).to eq 'Array'
    cmps = cmps[0][:product_id]
    cmp=Savon::So24::Model::Product.find cmps
    expect(cmp.class.name).to eq 'Hash'
  end


end