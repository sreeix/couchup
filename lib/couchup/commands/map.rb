module Couchup  
  module Commands
    class Map
      def run(*params)
        rows = MapReduce.map(*params)
        puts "Found #{rows.size} item(s)"
        rows
      end
    
      def self.describe(p = nil)
        "Runs a view with just the map function and returns the results"
      end
    end
  end
end