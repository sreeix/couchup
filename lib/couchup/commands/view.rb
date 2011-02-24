module Couchup
  module Commands
    class View
      def run(*params)
        MapReduce.reduce(*params)
      end
    
      def self.describe(params = nil)
        "Executes the given View. Runs Map and Reduce and retuns the results"
      end
    end
  end
end