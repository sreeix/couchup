require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
module Couchup
  module Commands
    describe Map do
      before(:all) do
        ddoc = {
          "_id" => "_design/Rider",
          "views" => {
            "all" => {
              "map" => "function(doc){if(doc.name) emit(doc.name, 1)}",
              "reduce" => "_sum"
            }
          }
        }
        database.save_doc(ddoc)
      end
      after(:each) do
         reset_data!
       end
      
      describe "simple map" do
        it "with no documents should return empty" do
          res = Map.new.run("Rider/all")
          res.size.should == 0
        end

        it "with documents should find all" do
          5.times {|n| database.save_doc({:name => "foo_#{n}"})}
          res = Map.new.run("Rider/all")
          res.size.should == 5
        end
      end

      describe "map with a key" do
        it "should return nothing when key is not found" do
          res = Map.new.run("Rider/all", "xxx")
          res.size.should == 0
        end

        it "should find one" do
          database.save_doc({:name => "foo"})
          res = Map.new.run("Rider/all", "foo")
          foo = res.first
          foo["_id"].should_not be_nil
          foo["_rev"].should_not be_nil
          foo["name"].should  == "foo"
          
          res.size.should == 1
        end

        it "should find all matching" do
          database.save_doc({:name => "foo"})
          database.save_doc({:name => "foo"})
          database.save_doc({:name => "bar"})
          res = Map.new.run("Rider/all", "foo")
          res.size.should == 2
          names = res.collect{|r| r["name"]}.uniq
          names.size.should == 1
          names.should include("foo")
          names.should_not include("bar")
        end
      end
      describe "map with multiple keys" do
        it "returns all matching keys" do
          database.save_doc({:name => "foo"})
          database.save_doc({:name => "foo"})
          database.save_doc({:name => "bar"})
          res = Map.new.run("Rider/all", "foo", "bar", "tar")
          res.size.should == 3
          names = res.collect{|r| r["name"]}.uniq
          names.size.should == 2
          names.should include("foo")
          names.should include("bar")
          names.should_not include("tar")
        end  

        it "returns matching keys" do
          database.save_doc({:name => "foo"})
          database.save_doc({:name => "foo"})
          database.save_doc({:name => "bar"})

          res = Map.new.run("Rider/all", ["bar", "tar"])
          res.size.should == 1
        end  
      end
      describe "startkey and end key " do
        it "returns matching keys from start" do
          database.save_doc({:name => "foo"})
          res = Map.new.run("Rider/all", {:startkey => "foo"})
          res.size.should == 1
        end

        it "returns matching keys from start" do
          database.save_doc({:name => "foo"})
          database.save_doc({:name => "bar"})
          res = Map.new.run("Rider/all", {:startkey => "bar", :endkey => 'foo'})
          res.size.should == 2
        end

        it "returns matching keys till end" do
          database.save_doc({:name => "foo"})
          database.save_doc({:name => "bar"})
          database.save_doc({:name => "gar"})
          res = Map.new.run("Rider/all", { :endkey => 'foo'})
          res.size.should == 2
          names = res.collect{|r| r["name"]}
          names.should include "foo"
          names.should include "bar"
          names.should_not include "gar"
        end
      end
    end  
  end
end
