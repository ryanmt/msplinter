require 'rubabel/molecule/fragmentable'
require 'rubabel/fragment_tree/node'

module Rubabel
  class FragmentTree
    include Enumerable # What does this buy me?

    attr_reader :root
    def initialize(*args)
      @root = Fragment.new(*args)
    end
    def push(*args)
      tmp = Fragment.new(*args)
      tmp.parent = @root
    end
    alias :<< :push 
  end
end
