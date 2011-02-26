module Couchup
  module Commands
    class View
      def run(*params)
        rows = MapReduce.reduce(*params)
        puts "Found #{rows.size} item(s)"
        rows.each{|r| puts r.inspect}
        nil
      end
    
      def self.describe(params = nil)
        "Executes the given View. Runs Map and Reduce and retuns the results"
      end
    end
  end
end