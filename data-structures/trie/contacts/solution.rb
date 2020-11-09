class Node

  attr_reader :children
  attr_accessor :stat

  def initialize
    @stat = 1
    @children = {}
  end

  def add(char)
    if contains?(char)
      child = get(char)
      child.stat += 1
      return child
    end

    @children[char] = Node.new
  end

  def contains?(char)
    @children.has_key?(char)
  end

  def get(char)
    @children.fetch(char)
  end
end

class Trie

  attr_accessor :root

  def initialize
    @root = Node.new
  end

  def add(word)
    node = @root

    word.each_char do |char|
      node = node.add(char)
    end
  end

  def find(word)
    node = @root

    word.each_char do |char|
      if node.contains?(char)
        node = node.get(char)
      else
        return 0
      end
    end

    node.stat
  end
end

t = Trie.new

lines_count = gets.to_i

lines_count.times do
  operation, string = gets.chomp.split(' ')
  if operation == 'add'
    t.add(string)
  else
    puts t.find(string)
  end
end

