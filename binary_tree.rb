class BinaryTree
  extend Forwardable

  class Node
    attr_reader :value

    attr_accessor :parent, :less, :more

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

    def find(&block)
      walk.find(&block)
    end

    def walk(&block)
      if block_given?
        (less && less.walk(&block)) ||
          yield(self) ||
          (more && more.walk(&block))
      else
        enum_for(:walk)
      end
    end

    def exists?(val)
      !!find { |n| n.value == val }
    end

    def remove(val)
      node = find { |n| n.value == val }

      return false unless node


      next_node = node.more || node.less

      if node.parent
        if node.parent.less == node
          node.parent.less = next_node
        elsif node.parent.more == node
          node.parent.more = next_node
        end
      end

      if next_node
        next_node.parent = node.parent
      end

      node.parent = nil # out of the tree

      node
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

  def_delegators :root, :each, :remove, :find, :exists?
end
