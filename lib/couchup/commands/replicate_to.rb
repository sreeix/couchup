module Couchup
  module Commands
    class ReplicateTo
      def run(*params)
        dest = params.shift 
        option = params.shift
        dest_db = (dest =~ /(http\w:\/\/.*)\/(.*)/) ? CouchRest::Database.new(CouchRest::Server.new($1), $2) : CouchRest::Database.new(Couchup.server, dest) 
        Couchup.database.replicate_to dest_db, (option.to_s == "continous")
      end
      
      def self.describe
       { :description => "Allows replication to different databases",
        :examples => ["replicate_to :riders_dev", "replicate_to 'http://foo.bar.com:5984/billing', :continous"],
        :usage => "replicate_to <target_db>, options"
       }
      end
      
    end
  end
  
end