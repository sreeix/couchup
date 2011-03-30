module Couchup  
  module Commands
    class Show
      def run(*param)
        option = param.first.to_s
        if(option.blank? || option == 'databases' )
          ap Couchup.databases
        else
          ap Couchup.views(param.second)
        end
      end

      def self.describe
        {
          :description => "show databases or views on the current instance/database",
          :details => "show [:databases | :views], [:design]",
          :examples => ["show", "show :databases", "show :views"]
        }
      end
    end
  end
end