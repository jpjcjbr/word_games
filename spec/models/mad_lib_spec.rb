#encoding: utf-8
require 'spec_helper'

describe "MadLib" do

  context "should set the parts of speech" do
    it "with 1 simple part" do
      madLib = MadLib.create(:text => "{name}")
      madLib.has_field?("Name (1)").should be_true
    end

    it "with 1 complex part" do
      madLib = MadLib.create(:text => "{name, aaa}")
      madLib.has_field?("Name, aaa (1)").should be_true
    end

    it "with 2 complex parts" do
      madLib = MadLib.create(:text => "{name, aaa} abcd {name2, bbb}")
      madLib.has_field?("Name, aaa (1)").should be_true
      madLib.has_field?("Name2, bbb (1)").should be_true
    end

    it "with 2 complex parts of the same type" do
      madLib = MadLib.create(:text => "{name, aaa} abcd {name, aaa}")
      madLib.has_field?("Name, aaa (1)").should be_true
      madLib.has_field?("Name, aaa (2)").should be_true
    end
  end

  context "should fill field with value" do
    it "with 1 simple part" do
      madLib = MadLib.create(:text => "{name, aaa}")
      solution = madLib.solutions.create
      solution.fill_field("Name, aaa (1)", :with => "JP")

      solution.resolve.should eq("JP")
    end

    it "with 2 complex parts" do
      madLib = MadLib.create(:text => "{name, aaa} abcd {name2, bbb}")
      solution = madLib.solutions.create
      solution.fill_field("Name, aaa (1)", :with => "JP")
      solution.fill_field("Name2, bbb (1)", :with => "BBBB")

      solution.resolve.should eq("JP abcd BBBB")
    end

    it "with 2 complex parts of the same type filled in wrong order" do
      madLib = MadLib.create(:text => "{name, aaa} abcd {name, aaa}")
      solution = madLib.solutions.create
      solution.fill_field("Name, aaa (2)", :with => "JP")
      solution.fill_field("Name, aaa (1)", :with => "BBBB")

      solution.resolve.should eq("BBBB abcd JP")
    end
  end
end