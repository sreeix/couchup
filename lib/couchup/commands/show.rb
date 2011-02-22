module Commands
  class Show
    
    def run(param = "databases")
      puts Couchup.databases.inspect
    end
    def self.describe
      "show databases"
    end
  end
end