module Commands
  class Map
    def run(*params)
      name = params.shift
      view_params = {}
      view_params.merge!( :key => params.first) if params.size == 1
      view_params.merge!( :keys => params) if params.size == 2
      response = Couchup.database.view(name, view_params)
      puts "Found #{response['total_rows']} items"
      response["rows"].each{|r| puts r.inspect}
    end
    
    def self.describe(p = nil)
      "Runs a view with just the map function and retuns the results"
    end
  end
end