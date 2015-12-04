require 'spec_helper'


RSpec.describe BinaryTree do
  subject { BinaryTree.new([3,7,5,6,10,1]) }

  it "forms a correct binary tree" do
    expect(subject.each.to_a).to eq([1,3,5,6,7,10])
  end

  it "finds values" do
    expect(subject.find(5)).to eq(true)
    expect(subject.find(4)).to eq(false)
  end
end
