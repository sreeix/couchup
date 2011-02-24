module Couchup
  module Commands
    class ReplicateTo
      def run(*params)
        dest = params.shift 
        option = params.shift
        dest_db = (dest =~ /(http:\/\/.*)\/(.*)/) ? CouchRest::Database.new(CouchRest::Server.new($1), $2) : CouchRest::Database.new(Couchup.server, dest) 
        Couchup.database.replicate_to dest_db, (option.to_s == "continous")
      end
      
      def self.describe
        "Allows replication to different databases. Try replicate_to 'http://foo.bar.com:5984/billing' :continous"
      end
      
    end
  end
  
end