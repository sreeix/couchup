require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
module Couchup
  module Commands
    describe Map do
      before(:all) do
        ddoc = {
          "_id" => "_design/Rider",
          "views" => {
            "all" => {
              "map" => "function(doc){emit(doc['_id'], 1)}",
              "reduce" => "_sum"
            }
          }
        }
        database.save_doc(ddoc)
      end
      
      describe "simple map" do
        after(:each) do
          reset_data!
        end
        it "with no documents should return empty" do
          res = Map.new.run("Rider/all")
          res.size.should ==0
        end

        it "with documents should find all" do
          5.times {|n| database.save_doc({:name => "foo_#{n}"})}
          res = Map.new.run("Rider/all")
          res.size.should == 5
        end
      end

    end  
  end
end
