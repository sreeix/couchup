class Couchup
  class << self
    attr_accessor :port, :host
    def ready?
      uuid = nil
      begin
        puts "#{host}:#{port}"  
        uuid = CouchRest::Server.new("#{host}:#{port}").next_uuid
      rescue
        puts $!.backtrace
        puts $!.inspect
      end
      puts uuid
      !uuid.nil?
    end
  end
end