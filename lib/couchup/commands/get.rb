module Couchup
  module Commands
    class Get
      def run(id = nil)
        match = id.nil? ? Couchup.all.collect{|c| c["doc"]} : Couchup.get(id) 
        ap match
        match
      end

      def self.describe
        {:description => "Retrives documents from the current database",
        :usage  => "get [:doc], [<id>]",
        :examples => ["get :doc, '2a663b5936f98fe225d64fcaa89e3281'", "get"]}
        
      end
    end
  end
end