require 'rubabel/molecule/fragmentable'

module Rubabel
  class Fragment << Molecule
    include Molecule::Fragmentable
    def adduct?
      not @adduct.empty?
    end
    def initialize(*args)
      # call a check for adducts
    end
  end
end
