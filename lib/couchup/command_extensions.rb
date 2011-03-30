module Couchup
  module CommandExtensions
    module ClassMethods
    end
    
    def self.included(receiver)
      receiver.extend ClassMethods
    end
    
    def needs_db!
      raise ArgumentError, "Please select a database before executing this request" if ::Couchup::Couchup.database.nil?
    end
    
  end
end