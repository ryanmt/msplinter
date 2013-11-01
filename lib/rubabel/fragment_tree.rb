require 'rubabel/molecule/fragmentable'
require 'rubabel/fragmentation_tree/node'

module Rubabel
  class FragmentTree
    include Enumerable # What does this buy me?

    attr_reader :root
    def initialize(*args)
      @root = Node.new(*args)
    end
    def push(*args)
      tmp = Node.new(*args)
      tmp.parent = @root
    end
    alias :<< :push 
  end
end
