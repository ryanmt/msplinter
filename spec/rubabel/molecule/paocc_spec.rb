require 'spec_helper'

require 'rubabel'
require 'rubabel/molecule/fragmentable'
require 'pry'

$VERBOSE = nil

describe Rubabel::Molecule::Fragmentable do
  describe "Phosphate Attack On ester Carbon :paoc" do 
    it "produces cyclized product" do 
      @mol = Rubabel["CCCCCCCCCCCCCCCC(=O)OC(COP(=O)([O-])[O-])COC(=O)CCCCCCC/C=C\\CCCCCCCC"]
      @mol.write_file("paoc/root.svg", add_atom_index: true)
      resp = @mol.fragment()
      puts "RESP1"
      p resp
      resp = @mol.rearrange(resp)
      puts "RESP2"
      p resp
      resp.size.>(0).should be_true
      puts "RESP3"
      p resp
      resp.flatten!
      puts "RESP4"
      p resp
      resp.uniq!{|a| a.csmiles}
      # output image files for products
      #resp.each_with_index{|mol,i| mol.write_file("paoc/#{mol.to_s.gsub("/", '-').gsub("\\", '_')}.svg", add_atom_index: true) }

      # Test for the proper products
      resp.include?(Rubabel["CCCCCCCC/C=C\\CCCCCCCC(=O)[O-]"]).should be_true
      resp.include?(Rubabel["[O-]C(=O)CCCCCCC/C=C/CCCCCCCC"]).should be_false
      resp.include?(Rubabel["[O-]C(=O)CCCCCCC/C=C\\CCCCCCCC"]).should be_true
      resp.include?(Rubabel["[O-]C(=O)CCCCCCCCCCCCCCC"]).should be_true
      resp.include?(Rubabel["[O-]P1(=O)OCC(COC(=O)CCCCCCC/C=C\\CCCCCCCC)O1"]).should be_true

      # Print out the mol_wt
      # resp.each_with_index{|mol,i| p mol; p mol.mol_wt }
    end
  end
end
