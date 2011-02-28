module Couchup
  module Commands
    class Get
      def run(id = nil)
        match = id.nil? ? Couchup.all.collect{|c| c["doc"]} : Couchup.get(id) 
        ap match
        match
      end

      def self.describe
        "get [id] retuns the document with the id. Just 'get' retrives all documents from the current database"
      end
    end
  end
end