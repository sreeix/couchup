module Couchup
  module Commands
    class Rename
      def run(*params)
        ap "Move database means that we replicate to a new db and delete the current one. if there are lots of documents, view building will be slow."
        src_db =  CouchRest.database!("http://#{Couchup.host}:#{Couchup.port}/#{params.shift}")
        dest_db =  CouchRest.database!("http://#{Couchup.host}:#{Couchup.port}/#{params.shift}")
        res = src_db.replicate_to(dest_db, false, true)
        src_db.delete! if res["ok"]
      end
      
      def self.describe
        "Renames database or a view both on the same Couch instance. eg. rename :src, :destination"
      end
    end
  end
  
end