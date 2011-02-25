module Couchup
  class View
    
    def initialize(name)
      @design, @name = name.split "/"
      design, name = name.split "/"
      begin
        doc = Couchup.database.get("_design/#{design}")
      rescue
        # handle creation of new design doc.
      end
    end

    def self.create(name, file_contents)
      v = doc["views"][name]
      map, reduce = parse(file_contents)

      puts "View Exists overwriting." unless v.nil? 
      v = (doc["views"][name]= {})  if v.nil? 
      v["map"] = map
      v["reduce"] = reduce unless reduce.blank?
      Couchup.database.save_doc(doc)
    end
    
    def self.parse(file_contents)
      file_contents =~ /-+BEGIN Map-+(.*)^-+END-+.*BEGIN Reduce.*-+(.*)^-+END-*/m
      [$1.strip, $2.strip]
    end
  end
end