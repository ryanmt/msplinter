require 'rubabel/molecule/fragmentable'
require 'rubabel/fragment_tree'

module Rubabel
  class FragmentSet
    attr_accessor :length, :molecules
    def initialize(arr_of_molecules)
      @length = arr_of_molecules.size
      @molecules = arr_of_molecules
      puts "MOLECULES: #{@molecules}"
      self
    end
  end
end
