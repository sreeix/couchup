module Couchup
  class Couchup
    class << self
      attr_accessor :port, :host, :user, :password
      attr_accessor :last_result

      def server
        @server ||= CouchRest::Server.new(host_string)
      end
    
      def database=(database)
        @db  = CouchRest.database!(host_string(database))
      end
      
      
      def host_string(database=nil)
        base_string = using_auth? ? "#{user}:#{password}@#{host}:#{port}" : "#{host}:#{port}"
        database.blank? ? "http://#{base_string}"  : "http://#{base_string}/#{database}"
      end
      def using_auth?
        !user.blank?
         @db = database.nil? ? nil : CouchRest.database!("http://#{host}:#{port}/#{database}")
      end

      def new_database(db)
        CouchRest.database!(host_string(db))
      end
      
      def database
        @db
      end
      
      
      def views(design = nil)
        params = design.nil? ? {:startkey => '_design', :endkey => '_design0'} : {:key => "_design\\#{design}"}
        designs = database.documents(params.merge(:include_docs => true))["rows"]
        designs.collect do |d|
          d["doc"]["views"].keys.collect do |view| 
            map = !d["doc"]["views"][view]["map"].blank?
            reduce = !d["doc"]["views"][view]["reduce"].blank?
            {"#{d['key'].gsub('_design/','')}/#{view}"  => {:reduce => reduce, :map => map}}
          end
        end.flatten
      end
      
      def delete_doc(id)
        doc = database.get(id)
        database.delete_doc(doc)
      end
      
      def delete_all_docs(view_name)
        all_docs = view_name.nil? ? all : MapReduce.map(view_name)
        all_docs.collect{|d| d["doc"]}.each do |doc|
          database.delete_doc(doc) unless (doc["_id"] =~ /^_design/)
        end
      end
      
      def ready?
        uuid = nil
        begin
          ap (info = server.info)
        rescue
          ap $!.inspect
          ap $!.backtrace if debug?
          
        end
        !info.nil?
      end

      def get(id)
        @db.get(id)
      end

      def all(options={})
        @db.documents(options.merge(:include_docs => true))["rows"]
      end
      
      def debug=(value)
        @debug = value
      end
      def debug?
        @debug == true
      end
    
      def databases
        server.databases
      end
    
    end
  end
end