module Couchup
  class MapReduce
    def self.map(*params)
      view({}, *params)
    end

    def self.reduce(*params)
      view({:reduce => true}, *params, )
    end
    private
    def self.view(options, *params)
      name = params.shift
      view_params = {:include_docs => true}.merge(options)
      view_params.merge!( :key => params.first) if params.size == 1
      view_params.merge!( :keys => params) if params.size == 2
      response = Couchup.database.view(name, view_params)
      puts "Found #{response['total_rows']} items"
      response["rows"].each{|r| puts r.inspect}
    end
  
    
  end
end