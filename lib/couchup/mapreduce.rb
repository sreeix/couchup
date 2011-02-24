module Couchup
  class MapReduce
    def self.map(*params)
      view({}, *params)
    end

    def self.reduce(*params)
      view({:reduce => true}, *params)
    end
    
  private
    def self.view(options, *params)
      name = params.shift
      view_params = {:include_docs => true}.merge(options)
      if params.size == 1
        val = params.first
        if val.is_a? Array
          view_params.merge!(:keys => val) 
        elsif val.is_a? Hash
          view_params.merge!(val)
        else
          view_params.merge!( :key => val) if val
        end
      end
      response = Couchup.database.view(name, view_params)
      puts "Found #{response['total_rows']} items"
      response["rows"].each{|r| puts r.inspect}
    end
  end
end