module Couchup  
  module Commands
    class Show
      def run(param)
        param = param.to_s
        if(param.blank? || param == 'databases' )
          puts Couchup.databases.inspect
        else
          puts Couchup.views.inspect
        end
      end

      def self.describe
        "show databases if databases is specified or views if vies is specified. defaults to databases."
      end
    end
  end
end