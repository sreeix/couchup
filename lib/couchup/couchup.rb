module Couchup
  class Couchup
    class << self
      attr_accessor :port, :host
      def server
        @server ||= CouchRest::Server.new("http://#{host}:#{port}")
      end
    
      def database=(database)
        @db  = CouchRest.database!("http://#{host}:#{port}/#{database}")
      end
    
      def database
        @db
      end
      
      def views(design = nil)
        params = design.nil? ? {:startkey => '_design', :endkey => '_design0'} : {:key => "_design\\#{design}"}
        designs = database.documents(params.merge(:include_docs => true))["rows"]
        designs.collect do |d|
          d["doc"]["views"].keys.collect{|view| "#{d['key'].gsub('_design/','')}/#{view}"}
        end.flatten
      end
      def delete_doc(id)
        doc = database.get(id)
        database.delete_doc(doc)
      end
      def delete_all_docs(view_name)
        all_docs = view_name.nil? ? all(:include_docs => true)["rows"] : MapReduce.map(view_name)
        all_docs.collect{|d| d["doc"]}.each do |doc|
          database.delete_doc(doc) unless (doc["_id"] =~ /^_design/)
        end
      end
      
      def ready?
        uuid = nil
        begin
          puts (info = server.info)
        rescue
          puts $!.backtrace
          puts $!.inspect
        end
        !info.nil?
      end

      def get(id)
        @db.get(id)
      end

      def all(options={})
        @db.documents(options)
      end
    
      def databases
        server.databases
      end
    
    end
  end
end