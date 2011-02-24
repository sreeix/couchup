module Couchup
  module Commands
    class Drop
      def run(*params)
        db = params.first.nil? ? Couchup.server.database : Couchup.server.database(params.first)
        db.delete!
      end

      def self.describe
        "Drops a database. Use it with drop <dbname>"
      end
    end
  end
end