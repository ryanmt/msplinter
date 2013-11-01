require_relative '../msplinter'

require 'yaml'


module Msplinter
  module Rubabel
    config_file = YAML.load_file(File.join(File.dirname(__FILE__), "../../config.yml"))
    rule_group_map = config_file[:rule_group_map]
    SmartSearchesByGroup = config_file[:smart_search_map]
    rearranged = Hash.new {|h,k| h[k] = []}
    rule_group_map.each_pair {|key, arr| arr.map {|grp| rearranged[grp] << key } }
    RulesByFunctionalGroups = rearranged
    FunctionalGroupsByRules = rule_group_map

    #check the rules... 
    def self.search_molecule_for_possible_rules(molecule)
      rules = []
      p FunctionalGroupsByRules
      SmartSearchesByGroup.map do |k, v|
        rules << RulesByFunctionalGroups[k] if molecule.matches v ## Simple test
      end
      # How should I query the structure?
      #1. A mapped list of functions for each structure?
      #2. A atom by atom iterative search?
      #3. Smart string searches?
      rules.flatten.uniq

      # Check the rules for "no-" modifiers... 
      # Modify the rules to eliminate the "no-" ones
    end
  end
end

if $0 == __FILE__
  require 'pry'
  mol = Rubabel["C(=O)C(O)C(=O)NC"]
  p Msplinter::Rubabel.search_molecule_for_possible_rules(mol)
end
