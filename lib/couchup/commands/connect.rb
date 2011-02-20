module Commands
  class Connect
    def run(params ={})
      Couchup.host = params[:host] || "locahost"
      Couchup.port = params[:post] || 5984
      if(Couchup.ready?)
        puts "Connected to #{Couchup.host}:#{Couchup.port}" 
      else
        puts "Could not connect to #{Couchup.host}:#{Couchup.port}"
      end
    end
  end
end