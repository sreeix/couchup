module Couchup
  module Commands
    class Help
      def run(param = nil)
        param.nil? ? show_all : show(param.camelize)
        nil
      end
      def show(command)
        k = Commands.const_get(command.to_s)
        ap k.describe
      end
      
      def show_all
        Commands.constants.each do |stuff|
          k = Commands.const_get(stuff)
          print stuff.underscore
          print (stuff.underscore.size > 10) ? "\t" : "\t\t"  
          ap k.respond_to?(:describe) ? k.describe[:description] : "No Help"
        end
        ap "Type help <command> for more detailed info"
      end
    
      def self.describe
       { :description =>  "Help on the system",
        :usage => "help [<command>]",
        :examples => ["help", "help :get"]}
        
      end
    end
  end
end