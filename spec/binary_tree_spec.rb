require 'spec_helper'


RSpec.describe BinaryTree do
  it "forms a correct binary tree" do
    tree = BinaryTree.new([3,7,5,6,10,1])

    expect(tree.each.to_a).to eq([1,3,5,6,7,10])
  end
end
