module Couchup
  module Commands
    class Get
      def run(id = nil)
        id.nil? ? Couchup.all : Couchup.get(id) 
      end

      def self.describe
        "get [id] retuns the document with the id"
      end
    end
  end
end