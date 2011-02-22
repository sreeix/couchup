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
          uuid = server.next_uuid
        rescue
          puts $!.backtrace
          puts $!.inspect
        end
        !uuid.nil?
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