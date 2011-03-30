require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module Couchup
  module Commands
    describe Compact do
      before(:all) do
        reset_data!
      end
      describe "without any parameter" do
        it "should compact current database" do
          res = Compact.new.run()
          res["ok"].should be_true
        end

        it "should fail when on no database" do
          Couchup.database = nil
          begin
            Compact.new.run()
            fail("Expected compact to fail")
          rescue ArgumentError => e
          end
        end
      end

      describe "when database is specified" do
        it "should compact specified db when on no db" do
          Couchup.database = nil
          res = Compact.new.run(database.name)
          res["ok"].should be_true
        end
      end
    end
  end
  
end
