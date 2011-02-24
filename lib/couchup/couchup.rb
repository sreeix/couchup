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
        @db.documents
      end
    
      def databases
        server.databases
      end
    
    end
  end
end