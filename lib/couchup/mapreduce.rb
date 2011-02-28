module Couchup
  class MapReduce
    def self.map(*params)
      #FIXME. should probably get view meta data to do one view call. but this is also doing 2 calls.
      begin
        response = view({:include_docs => true}, *params)
      rescue RestClient::BadRequest
        response = view({:reduce => false, :include_docs => true}, *params)
      end
      
      docs = response["rows"].collect do |r|
        r["doc"].instance_eval "def save
          ::Couchup::Couchup.database.save_doc(self)
        end
        "
        r["doc"]
      end
      
    end

    def self.reduce(*params)
      view({:reduce => true}, *params)
    end
    
  private
    def self.view(options, *params)
      name = params.shift
      view_params = options
      if params.size == 1
        val = params.first
        if val.is_a? Array
          view_params.merge!(:keys => val)
        elsif val.is_a? Hash
          view_params.merge!(val)
        else 
          view_params.merge!(:key => val) unless val.nil?
        end
      end
      response = Couchup.database.view(name, view_params)
    end
  end
end