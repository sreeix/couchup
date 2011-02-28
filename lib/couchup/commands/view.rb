module Couchup
  module Commands
    class View
      def run(*params)
        rows = MapReduce.reduce(*params)
        ap "Found #{rows.size} item(s)"
        ap rows
        rows
      end
    
      def self.describe(params = nil)
        "Executes the given View. Runs Map and Reduce and retuns the results"
      end
    end
  end
end