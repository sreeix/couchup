module Couchup
  class MapReduce
    def self.map(*params)
      #FIXME. should probably get view meta data to do one view call. but this is also doing 2 calls.
      begin
        view({}, *params)
      rescue RestClient::BadRequest
        view({:reduce => false}, *params)
      end
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
        view_params.merge!(:keys => val) if val.is_a? Array
        view_params.merge!(val) if val.is_a? Hash
        view_params.merge!(:key => val) unless val.nil?
      end
      response = Couchup.database.view(name, view_params)
      rows = response["rows"]
      puts "Found #{rows.size} items"
      rows.each{|r| puts r.inspect}
    end
  end
end