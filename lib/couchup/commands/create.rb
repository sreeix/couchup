module Couchup
  module Commands
    class Create
      def run(*params)
        what = params.shift.to_s
        if(what == 'view')
          create_view(params.shift, *params)
        else
          Couchup.server.database!(params.first)
          Use.new.run(params.first)
        end
      end
      
      def create_view(name, *params)
        raise "Please set your EDITOR env variable before using view" if ENV['EDITOR'].nil? 
        view = ::Couchup::View.new(name)
        if(params.size == 0)  
          file = Tempfile.new(name.gsub("/", "_"))
          tmp_file_path = file.path
          file.write("------BEGIN Map-------\n")
          file.write( view.map? ? view.map : ::Couchup::View::MAP_TEMPLATE)
          file.write("\n------END------\n")
        
          file.write("\n------BEGIN Reduce(Remove the function if you don't want a reduce)-------\n")
          file.write(view.reduce? ? view.reduce: ::Couchup::View::REDUCE_TEMPLATE )
          file.write("\n------END------\n")
          file.write("\nDelete Everything to do nothing.\n")
          file.close
        
          `#{ENV['EDITOR']} #{tmp_file_path}`
          contents = File.open(tmp_file_path).read
          unless contents.blank?
            ::Couchup::View.create_from_file(name, contents) 
          end
          file.close
          file.unlink
        else
          map = params.shift
          reduce = params.shift
          ::Couchup::View.create(name, map, reduce)
        end
      end
      
      def self.describe
        {:description => "Creates a new database and switches to the database",
        :usage => " create :database | :view , name",
        :examples => ["create :database, riders", "create :view, 'Riders/test'"]}
      end
    end
  end
end