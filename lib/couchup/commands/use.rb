module Commands
  class Use
    def run(database)
      
      if Couchup.databases.include? database
        Couchup.database = database
      else
        puts "Database was not found"
      end
    end
    
    def self.describe
      "Use provided database"
    end
  end
end