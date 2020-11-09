require 'set'

class Edge
  attr_accessor :src, :dst, :length

  def initialize(src, dst, length = 1)
    @src = src
    @dst = dst
    @length = length
  end

  def eql?(other)
    self.src == other.src && self.dst == other.dst
  end

  def hash
    self.src.hash + self.dst.hash
  end
end

class Graph < Array
  attr_reader :edges

  def initialize
    @edges = Set.new
  end

  def connect(src, dst, length = 1)
    unless self.include?(src)
      raise ArgumentException, "No such vertex: #{src}"
    end
    unless self.include?(dst)
      raise ArgumentException, "No such vertex: #{dst}"
    end
    @edges.add Edge.new(src, dst, length)
  end

  def connect_mutually(vertex1, vertex2, length = 1)
    self.connect vertex1, vertex2, length
    self.connect vertex2, vertex1, length
  end

  def neighbors(vertex)
    neighbors = []
    @edges.each do |edge|
      neighbors.push edge.dst if edge.src == vertex
    end
    neighbors.uniq
  end

  def length_between(src, dst)
    @edges.each do |edge|
      return edge.length if edge.src == src and edge.dst == dst
    end
    nil
  end

  def dijkstra(src)
    distances = {}
    previouses = {}
    self.each do |vertex|
      distances[vertex] = nil # Infinity
      previouses[vertex] = nil
    end
    distances[src] = 0
    vertices = self.clone
    until vertices.empty?
      nearest_vertex = vertices.inject do |a, b|
        next b unless distances[a]
        next a unless distances[b]
        next a if distances[a] < distances[b]
        b
      end
      break unless distances[nearest_vertex] # Infinity
      neighbors = vertices.neighbors(nearest_vertex)
      neighbors.each do |vertex|
        alt = distances[nearest_vertex] + vertices.length_between(nearest_vertex, vertex)
        if distances[vertex].nil? or alt < distances[vertex]
          distances[vertex] = alt
          previouses[vertex] = nearest_vertex
          # decrease-key v in Q # ???
        end
      end
      vertices.delete nearest_vertex
    end
    distances.values.map { |d| d.nil? ? -1 : d }
  end

  private

  def get_path(previouses, src, dest)
    path = get_path_recursively(previouses, src, dest)
    path.is_a?(Array) ? path.reverse : path
  end

  # Unroll through previouses array until we get to source
  def get_path_recursively(previouses, src, dest)
    return src if src == dest
    return nil if previouses[dest].nil?
    [dest, get_path_recursively(previouses, src, previouses[dest])].flatten
  end
end

# graph = Graph.new
# (1..4).each {|node| graph.push node }
# graph.connect_mutually 1, 2, 6
# graph.connect_mutually 1, 3, 6

graphs_count = gets.chomp.to_i

graphs_count.times do
  graph = Graph.new

  nodes_count, edges_count = gets.chomp.split(' ')

  (1..nodes_count.to_i).each { |node| graph.push node }

  edges_count.to_i.times do
    start_node, end_node = gets.chomp.split(' ').map(&:to_i)
    graph.connect_mutually(start_node, end_node, 6)
  end

  start_node = gets.chomp.to_i

  res = graph.dijkstra(start_node)
  res.delete_at(start_node - 1)
  puts res.join(' ')
end


