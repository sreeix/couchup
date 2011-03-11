module Couchup
  class View
    MAP_TEMPLATE = "function(doc){\n}\n"
    REDUCE_TEMPLATE = ""
    
    def initialize(name)
      @design, @name = name.split "/"
      begin
        @doc = Couchup.database.get("_design/#{@design}")
      rescue
        ap "Design #{@design} not found creating a new one"
        @doc = {"_id" => "_design/#{@design}", :language => 'javascript', :views => {}}
        save
        @doc = Couchup.database.get("_design/#{@design}")
      end
    end
    
    def save
      Couchup.database.save_doc(@doc)  
    end
    
    def map
      @doc["views"][@name]["map"]
    end
    
    def map=(fun)
      if map?
        @doc["views"][@name]["map"] = fun 
      else
        @doc["views"][@name] = {:map => fun}
      end
    end

    def reduce
      @doc["views"][@name]["reduce"]
    end

    def reduce=(fun)
      if reduce?
        @doc["views"][@name]["reduce"] = fun
      else
        @doc["views"][@name] ={:reduce => fun}
      end
    end

    def map?
      @doc["views"][@name] && !@doc["views"][@name]["map"].blank?
    end

    def reduce?
      @doc["views"][@name] && !@doc["views"][@name]["reduce"].blank?
    end

    def delete!
      @doc["views"].delete(@name)
      save
    end
    
    
    def self.create_from_file(name, file_contents)
      map, reduce = parse(file_contents)
      create(name, map, reduce)
    end

    def self.create(name, map, reduce)
      v = new(name)
      v.map = map
      v.reduce = reduce unless reduce.blank?
      ap v
      v.save
    end
    
    def self.parse(file_contents)
      file_contents =~ /-+BEGIN Map-+(.*)^-+END-+.*BEGIN Reduce.*-+(.*)^-+END-*/m
      [$1.strip, $2.strip]
    end
  end
end