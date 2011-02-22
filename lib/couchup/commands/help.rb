module Commands
  class Help
    def run(param = nil)
      commands = param.nil? ? Commands.constants : [param.camelize]
      commands.each do |stuff|
        k = Commands.const_get(stuff)
        print stuff.downcase; print "\t\t"
        puts k.respond_to?(:describe) ? k.describe : "No Help"
      end
    end
    
    def self.describe
      "Help on the system, 'help :get' will provider help about using get."
    end
  end
end