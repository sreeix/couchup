require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module Couchup
  module Commands
    describe Use do
      it "stays on the same database if db does not exist" do
        Couchup.database.name.should == TEST_DATABASE
        res = Use.new.run("xxxxxx")
        res.should be_nil
        Couchup.database.name.should == TEST_DATABASE
      end
    end
  end
  
end
