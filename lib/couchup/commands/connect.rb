module Commands
  class Connect
    def run(params ={})
      Couchup.host = params[:host] || "locahost"
      Couchup.port = params[:post] || 5984
      puts "Connected to #{Couchup.host}:#{Couchup.port}" if(Couchup.ready?)
    end
  end
end