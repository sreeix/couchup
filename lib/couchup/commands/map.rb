module Couchup  
  module Commands
    class Map
      include ::Couchup::CommandExtensions
      def run(*params)
        needs_db!
        rows = MapReduce.map(*params)
        ap "Found #{rows.size} item(s)"
        ap rows
        rows
      end
    
      def self.describe(p = nil)
        {
          :description => "Runs a view with just the map function and returns the results",
          :usage => 'map <view_name> [options]',
          :examples => ["map 'Rider/top_ten'","map 'Rider/top_ten', 10", "map 'Rider/top_ten', {:startkey => '10', :endkey => '20'}","map 'Rider/top_ten', [1,2,3,10]" ]
        }
      end
    end
  end
end