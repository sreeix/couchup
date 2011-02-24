module Couchup
  module Commands
    class Create
      def run(*params)
        Couchup.server.database!(params.first)
        Use.new.run(params.first)
      end
      def self.describe
        "Creates a new database and switches to the database"
      end
    end
  end
end