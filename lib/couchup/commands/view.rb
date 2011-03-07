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
        {:description => "Executes the given View. Runs Map and Reduce and retuns the results",
          :usage => "view <view_name> [options]",
          :examples => ["view 'Riders/top_ten'", "view 'Riders/top_ten', [10,100,200]", "view 'Riders/top_ten', 10", "view 'Riders/top_ten', {:group_level=>2, :group=> true}"]
          }
      end
    end
  end
end