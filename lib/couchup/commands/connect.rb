module Couchup
  module Commands
    class Connect
      def run(host = 'localhost', port = 5984)
        Couchup.host = host
        Couchup.port = port
        if(Couchup.ready?)
          ap "Connected to #{Couchup.host}:#{Couchup.port}" 
        else
          ap "Could not connect to #{Couchup.host}:#{Couchup.port}"
        end
      end
      def self.describe
        "Connects to the couch server. Takes host and port defaults to 5984"
      end
    end
  end
end