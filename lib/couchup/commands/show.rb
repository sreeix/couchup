module Couchup  
  module Commands
    class Show
    
      def run(param = "databases")
        if(param == 'databases')
          puts Couchup.databases.inspect
        else
          puts Couchup.database.views.inspect
        end
      end
      def self.describe
        "show databases if databases is specified or views if vies is specified. defaults to databases."
      end
    end
  end
end