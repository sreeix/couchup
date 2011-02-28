module Couchup  
  module Commands
    class Map
      def run(*params)
        rows = MapReduce.map(*params)
        ap "Found #{rows.size} item(s)"
        ap rows
        rows
      end
    
      def self.describe(p = nil)
        "Runs a view with just the map function and returns the results"
      end
    end
  end
end