require 'spec_helper'

require 'rubabel'
require 'rubabel/fragment_tree.rb'

require 'pry'

$VERBOSE = nil
DefaultRules = [:cod, :oxe, :codoo, :oxepd, :oxh, :oxhpd]
FragmentTree = Rubabel::FragmentTree
$molecule_test_string = "LMGP04010962"
describe Rubabel::FragmentTree do 
  before :each do 
    @a =  Rubabel::FragmentTree::Fragment.new Rubabel[$molecule_test_string, :lmid]
    @tree = FragmentTree.new @a
  end
  it "Initializes as its own root molecule" do 
    @a.root.should == @a
  end
  it "holds a parent" do 
    @a.parent.should == @a
  end
  it "handles ms2" do 
    resp = @a.ms2(rules: [:cod])
    resp.map{|arr| arr.map(&:csmiles) }.flatten.should == Rubabel[$molecule_test_string, :lmid].fragment(rules: [:cod]).map {|arr| arr.map(&:csmiles) }.flatten
  end
  it "handles ms3 for everything" do 
    pending 
    resp = @a.ms3(rules: DefaultRules)
    resp.include?(Rubabel["[O-]C(=O)CCCCCCCCCCCCCCC"]).should be_true
    resp.include?(Rubabel["[O-]C(=O)CCCCCCC/C=C\\CCCCCCCC"]).should be_true
    # DOESN"T YET WORK
    resp.include?(Rubabel["[O-]P1(=O)OCC(OC(=O)CCCCCCCCCCCCCCCC)CO1"]).should be_true
    resp.include?(Rubabel["CCCCCCCC/C=C\\CCCCCCCC(=O)OCC1CO[P]([O-])(=O)O1"]).should be_true
  end
  it "matches with the :paoc rule" do 
    @mol = Rubabel["CCCCCCCCCCCCCCCC(=O)O[C@@H](COP(=O)([O-])[O-])COC(=O)CCCCCCC/C=C\\CCCCCCCC"]
    pending "restructure"
    #resp = @mol.fragment(rules: [:paoc])
    #resp.size.>(0).should be_true
  end
  it "it traverses the stack, in order to perform all possible fragmentations" do 
    resp = @a.msn
    resp.flatten.compact.map{|a| a.map(&:mol_wt)}.flatten.sort.uniq
  end
  it "Doesn't create the false product from this lipid test case (loss of a carbonyl from a glycerophosplipid in the middle of the chain" do
    @a.ms2.include?(Rubabel["[C@@H](P(=O)([O-])OC[C@@H](O)CO)(OC(=O)CCCCCCCCCCCCCCC)COC(=O)CCCCCCC/C=C\\CCCCCCCC"]).should be_false
    @a.ms2.include?(Rubabel["[C@@H](P(=O)([O-])OC[C@@H](O)CO)(OC(=O)CCCCCCCCCCCCCCC)COC(=O)CCCCCCC/C=C\\CCCCCCCC"]).should be_false
  end
end

