module Couchup  
  module Commands
    class Show
      def run(*param)
        option = param.first.to_s
        if(option.blank? || option == 'databases' )
          puts Couchup.databases.inspect
        else
          puts Couchup.views(param.second).inspect
        end
      end

      def self.describe
        "show databases if databases is specified or views if vies is specified. defaults to databases."
      end
    end
  end
end