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
        {:description => "Renames database or a view both on the same Couch instance. Replicates to new db and deletes the old. Hence slow.",
        :usage => "rename <src_database>, <target_database>",
        :examples => ["rename 'riders_test', 'riders_development'"]
      }
      end
    end
  end
  
end