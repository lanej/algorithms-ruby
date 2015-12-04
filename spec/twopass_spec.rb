require 'spec_helper'

describe Twopass do
  it "correctly identifies regions" do
    picture = [
      [1,1,1,1,1],
      [1,0,1,0,1],
      [1,0,1,0,1],
      [1,1,1,1,1],
    ]

    regions = Twopass.process(picture)

    pp Twopass.pretty_print(regions)

    expect(regions.size).to eq(3)
    expect(regions).to eq(
      [1, [
        [0,0],[0,1],[0,2],[0,3],[0,4],
        [1,0],[1,2],[1,4],
        [2,0],[2,2],[2,4],
        [3,3],[3,1],[3,2],[3,3],[3,4],
      ]],
      [0, [
        [1,1], [1,3],
      ]],
      [0, [
        [2,1], [2,3],
      ]],
    )
  end
end
