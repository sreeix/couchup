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
      
      it "Runs a simple map" do
        Map.new.run("Rider/all")
      end
    end  
  end
end
