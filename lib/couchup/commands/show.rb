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
        "show databases if databases is specified or views if views is specified. defaults to databases."
      end
    end
  end
end