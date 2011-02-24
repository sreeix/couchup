module Couchup
  module Commands
    class Restart
      def run(*params)
        Couchup.server.restart!
      end
    
      def self.describe
        "Restarts the couchdb server. Please be careful with it. It will not prompt you for anything."
      end
    end
  end
end