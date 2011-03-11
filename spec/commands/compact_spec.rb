require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module Couchup
  module Commands
    describe Compact do
      describe "without any parameter" do
        xit "should compact current database" do
          res = Compact.new.run()
          res["ok"].should be_true
        end

        xit "should fail when on no database" do
          Couchup.database = nil
          res = Compact.new.run()
          res.should be_nil
        end
      end

      describe "when database is specified" do
        xit "should compact specified db when on no db" do
          Couchup.database = nil
          res = Compact.new.run(database.name)
          res["ok"].should be_true
        end
      end
    end
  end
  
end
