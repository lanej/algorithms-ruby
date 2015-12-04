class BinaryTree
  extend Forwardable

  class Node
    attr_reader :less, :more, :value

    attr_accessor :parent

    def initialize(value, parent: nil)
      @value  = value
      @parent = parent
    end

    def insert(v)
      case value <=> v
      when 1 then insert_less(v)
      when -1 then insert_more(v)
      else false # equals
      end
    end

    def each(&block)
      if block_given?
        less && less.each(&block)
        yield value
        more && more.each(&block)
      else
        enum_for(:each)
      end
    end

    def find(val)
      case value <=> val
      when 1 then !!less && less.find(val)
      when -1 then !!more && more.find(val)
      else true # equals
      end
    end

    private

    def insert_less(v)
      less ? less.insert(v) : (@less = Node.new(v, parent: self))
    end

    def insert_more(v)
      more ? more.insert(v) : (@more = Node.new(v, parent: self))
    end
  end

  attr_reader :root

  def initialize(values=[])
    Array(values).each { |val| insert(val) }
  end

  def insert(val)
    root ? root.insert(val) : (@root = Node.new(val))
  end

  def_delegators :root, :each, :find
end
