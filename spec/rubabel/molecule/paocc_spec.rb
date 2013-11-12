require 'spec_helper'

require 'rubabel'
require 'rubabel/molecule/fragmentable'
require 'pry'

$VERBOSE = nil

describe Rubabel::Molecule::Fragmentable do
  describe "Phosphate Attack On ester Carbon :paoc" do 
    it "produces cyclized product" do 
      @mol = Rubabel["CCCCCCCCCCCCCCCC(=O)OC(COP(=O)([O-])[O-])COC(=O)CCCCCCC/C=C\\CCCCCCCC"]
      @mol = Rubabel["LMGP04010962", :lmid]
      @mol.write_file("paoc/root.svg", add_atom_index: true)
      fragments = @mol.fragment()
      rearranged = @mol.rearrange(fragments)
      rearranged.size.>(0).should be_true
      rearranged.flatten!
      rearranged.uniq!#{|a| a.molecules.map(&:csmiles) }
      # output image files for products
      #rearranged.each_with_index{|mol,i| mol.write_file("paoc/#{mol.to_s.gsub("/", '-').gsub("\\", '_')}.svg", add_atom_index: true) }

      # Test for the proper products
      molecules = rearranged.map{|a| a.molecules}.flatten
      # Rubabel["CCCCCCCC/C=C\\CCCCCCCC(=O)[O-]"], Rubabel["[O-]C(=O)CCCCCCC/C=C/CCCCCCCC"], Rubabel["[O-]C(=O)CCCCCCC/C=C\\CCCCCCCC"], Rubabel["[O-]C(=O)CCCCCCCCCCCCCCC"], Rubabel["[O-]P1(=O)OCC(COC(=O)CCCCCCC/C=C\\CCCCCCCC)O1"]

      mol_csmiles = molecules.map(&:csmiles)
      mol_csmiles.include?(Rubabel["CCCCCCCC/C=C\\CCCCCCCC(=O)[O-]"].csmiles).should be_true
      mol_csmiles.include?(Rubabel["[O-]C(=O)CCCCCCC/C=C/CCCCCCCC"].csmiles).should be_false
      mol_csmiles.include?(Rubabel["[O-]C(=O)CCCCCCC/C=C\\CCCCCCCC"].csmiles).should be_true
      mol_csmiles.include?(Rubabel["[O-]C(=O)CCCCCCCCCCCCCCC"].csmiles).should be_true
      mol_csmiles.include?(Rubabel["[O-]P1(=O)OCC(COC(=O)CCCCCCC/C=C\\CCCCCCCC)O1"].csmiles).should be_true

      # Print out the mol_wt
      # rearranged.each_with_index{|mol,i| p mol; p mol.mol_wt }
    end
  end
end
