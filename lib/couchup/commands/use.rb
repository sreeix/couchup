module Couchup
  module Commands
    class Use
      def run(database)
        db = database.to_s
        if Couchup.databases.include? db
          Couchup.database = db
          info = Couchup.database.info
          ap info
          info
        else
          ap "Database was not found"
        end
      end
    
      def self.describe
       { 
         :description => "Use provided database",
         :detail => "use <database>",
         :examples => ["use 'riders'"]
       }
      end
    end
  end
  
end