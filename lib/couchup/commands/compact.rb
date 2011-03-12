module Couchup
  module Commands
    class Compact
      def run(*params)
        db = params.shift
        if(db.nil?)
          instance = Couchup.database
        else
          instance = Couchup.new_database(db)
        end
        if instance.nil?
          ap "Database not found."
        else
          instance.compact!
        end
        
      end
      def self.describe
        {:description => "Compacts the current database or specified database. To preserve space.",
        :usage => "compact [db_name]",
        :examples =>[ "compact", "compact 'Riders/winners"]
        }
      end
    end
  end
end