module Couchup
  module Commands
    class Compact
      def run(*params)
        db = params.shift
        if(db.nil?)
          Couchup.database.compact!
        else
          Couchup.database(db).compact!
        end
      end
      def self.describe
        "Compacts the current database. To preserve space."
      end
    end
  end
end