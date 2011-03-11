require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module Couchup
  module Commands
    describe Use do
      it "stays on the same databse if db does not exist" do
        # res = Use.new.run(TEST_DATABASE)
        # res.should be_nil
        # # Couchup.database.name.should == TEST_DATABASE
      end
    end
  end
  
end
