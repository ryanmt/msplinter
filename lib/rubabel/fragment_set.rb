require 'rubabel/molecule/fragmentable'
require 'rubabel/fragment_tree'

module Rubabel
  class FragmentSet 
    include Enumerable
    attr_accessor :length, :molecules
    def initialize(arr_of_molecules)
      @length = arr_of_molecules.size
      @molecules = arr_of_molecules
    end
    def map!(&block)
      @molecules.map!(&block)
    end
    def each(&block)
      @molecules.each(&block)
    end
  end
end
