require 'set'

class Graph
  Vertex = Struct.new(:name, :neighbours, :dist)

  def initialize(nodes_count, graph)
    @vertices = {}
    nodes_count.times do |n|
      @vertices[n+1] = Vertex.new(n+1, Set.new, Float::INFINITY)
    end
    @edges = {}
    graph.each do |(v1, v2, dist)|
      @vertices[v1].neighbours.add(v2)
      @vertices[v2].neighbours.add(v1)
      @edges[[v1, v2]] = @edges[[v2, v1]] = dist
    end
    @dijkstra_source = nil
  end

  def dijkstra(source)

    q = @vertices.values

    @vertices[source].dist = 0

    until q.empty?
      u = q.min_by { |vertex| vertex.dist }
      break if u.dist == Float::INFINITY
      q.delete(u)
      u.neighbours.each do |v|
        vv = @vertices[v]
        if q.include?(vv) && vv.neighbours.size > 0
          alt = u.dist + @edges[[u.name, v]]
          vv.dist = alt if alt < vv.dist
        end
      end
    end

    @vertices.values.map { |vert| vert.dist == Float::INFINITY ? -1 : vert.dist }
  end
end

graphs_count = gets.chomp.to_i

graphs_count.times do

  nodes_count, edges_count = gets.chomp.split(' ')

  edges = []
  edges_count.to_i.times do
    start_node, end_node = gets.chomp.split(' ').map(&:to_i)
    edges.push [start_node, end_node, 6]
  end

  graph = Graph.new(nodes_count.to_i, edges)

  start_node = gets.chomp.to_i

  res = graph.dijkstra(start_node)

  res.delete_at(start_node - 1)
  puts res.join(' ')
end
