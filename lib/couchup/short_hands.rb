module Couchup
  module ShortHands
    def included(base)
      %w{create drop show}.each do |action|
        ['view', 'db'].each { |on| base.send "#{action}_#{on}"}
      end
      alias :create_database :create_db
      alias :drop_database :drop_db 
      alias :show_database :show_db 
    end

    def create_view(*params)
      create :view, *params
    end
    def create_db(*params)
      create :database, *params
    end

    def show_view(*params)
      show :view, *params
    end

    def show_db(*params)
      show :databases, *params
    end
    
    def create_db(*params)
      create :database, *params
    end
    
    def drop_view(*params)
      drop :view, *params
    end
   
    def drop_db(*params)
      drop :database, *params
    end
  end
  
end
