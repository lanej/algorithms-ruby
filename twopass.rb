require "logger"
require "pp"
require "set"

module Twopass
  def self.pretty_print(array_of_arrays)
    array_of_arrays.each { |row|
      puts row.join(" | ")
    }
  end

  def self.process(picture, debug: false)
    logger = Logger.new(debug ? STDOUT : nil)
    region = 0

    m = picture.size
    n = picture.first.size

    labels = m.times.map { n.times.map { |_| nil } }

    equivalence = Hash.new { |h,k| h[k] = [k] }

    for row in 0..m-1
      for col in 0..n-1
        west = if col - 1 >= 0
                 picture[row][col - 1]
               end

        north = if row - 1 >= 0
                  picture[row - 1][col]
                end


        value = picture[row][col]

        west_label  = west && labels[row][col-1]
        north_label = north && labels[row-1][col]

        if west && (west == value)
          logger.debug { "[#{row}][#{col}] matching west #{west_label}" }
          labels[row][col] = west_label
        elsif north && west && (north == value) && (west == value) && (west_label != north_label)
          min_label = [west_label, north_label].min
          labels[row][col] = min_label

          logger.puts "[#{row}][#{col}] merging north and west #{min_label}"

          equivalence[west_label] << north_label
          equivalence[north_label] << west_label
        elsif north && (north == value)
          logger.debug { "[#{row}][#{col}] matching north #{north_label}" }
          labels[row][col] = north_label
        else
          logger.debug { "[#{row}][#{col}] new region detected" }
          region += 1
          labels[row][col] = region
        end
      end
    end

    labels
  end
end

class DisjointSet
  def initialize(seeds)
    @roots = {}

    Array(seed).each { |set| add(set.to_set) }
  end
end
