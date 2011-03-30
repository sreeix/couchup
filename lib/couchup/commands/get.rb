module Couchup
  module Commands
    class Get
      include ::Couchup::CommandExtensions
      def run(id = nil)
        needs_db!
        match = id.nil? ? Couchup.all.collect{|c| c["doc"]} : Couchup.get(id) 
        ap match
        match
      end

      def self.describe
        {
          :description => "Retrives documents from the current database",
          :usage  => "get [:doc], [<id>]",
          :examples => ["get :doc, '2a663b5936f98fe225d64fcaa89e3281'", "get"]
        }
        
      end
    end
  end
end