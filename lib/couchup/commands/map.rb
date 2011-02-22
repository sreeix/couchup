module Couchup  
  module Commands
    class Map
      def run(*params)
        MapReduce.map(*params)
      end
    
      def self.describe(p = nil)
        "Runs a view with just the map function and retuns the results"
      end
    end
  end
end