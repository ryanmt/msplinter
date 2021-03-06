# Add rules to these two variables as needed
# Rule_names << :rule_names
# Rearrangements << :any_rule_names_that_are_just_rearrangements
require_relative "../fragmentable"
Rearrangements2 = []

module Rubabel
  class Molecule
    module Fragmentable
      ::Rearrangements2 << def rule_name
      #TODO remove this next line
      only_uniqs = true
        # Create a fragmentation block method
        fragment_sets = []
        fragment = lambda do |leaving_oxygen, attacked_carbon, anionic_oxygen|
          # Duplication and mapping identity to new atoms
          nmol = self.dup
          leaving_group_oxygen = nmol.atom(leaving_oxygen.id)
          product_carbon_to_link = nmol.atom(attacked_carbon.id)
          attacking_oxygen = nmol.atom(anionic_oxygen.id)
          #1
          nmol.delete_bond(leaving_group_oxygen, product_carbon_to_link)
          #2
          attacking_oxygen.charge=0
          #3
          leaving_group_oxygen.charge=-1
          #4
          nmol.add_bond!(product_carbon_to_link, attacking_oxygen)
          nmol.split
        end

        # Call the block on any search strings which make sense in the context of the code
        self.matches("[CX3](=[OX1])[OX2]CCCO-P(=[OX1])[O-]", only_uniqs).each do |arr|
          fragment_sets << fragment.call(arr[2], arr[3], arr.last)
        end
        self.matches("[CX3](=[OX1])[OX2]CCO-P(=[OX1])[O-]" , only_uniqs).each do |arr|
          fragment_sets << fragment.call(arr[2], arr[3], arr.last)
        end
        fragment_sets
      end

    end # Fragmentable
  end # Molecule
end #Rubabel


if $0 == __FILE__
  require 'bundler/setup'
  require 'rubabel'
  require 'pry'
  mol = Rubabel["LMGP04010962", :lmid]
  mol = Rubabel["CCCCCCCCCCCCCCCC(=O)OC(COP(=O)([O-])[O-])COC(=O)CCCCCCC/C=C\\CCCCCCCC"]
  p mol.rule_name
end
