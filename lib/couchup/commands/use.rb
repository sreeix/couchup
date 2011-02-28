module Couchup
  module Commands
    class Use
      def run(database)
        db = database.to_s
        if Couchup.databases.include? db
          Couchup.database = db
          ap Couchup.database.info
        else
          ap "Database was not found"
        end
      end
    
      def self.describe
        "Use provided database"
      end
    end
  end
  
end