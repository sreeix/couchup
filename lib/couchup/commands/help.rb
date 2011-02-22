module Commands
  class Help
    def run(option={})
      Commands.constants.each do |stuff|
        k = Commands.const_get(stuff)
        print stuff.downcase; print "\t\t"
        puts k.respond_to?(:describe) ? k.describe : "No Help"
      end
    end
    
    def self.describe
      "Help on the system, 'help put' will provider help about put."
    end
  end
end