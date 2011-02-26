module Couchup
  module Commands
    class Drop
      def run(*params)
        op_type = params.shift.to_s
        if op_type == 'database'
          db = params.first.nil? ? Couchup.server.database : Couchup.server.database(params.first)
          db.delete!
        end
        if op_type == 'view'
          ::Couchup::View.new(params.first).delete!
        end
      end

      def self.describe
        "Drops a database. Use it with drop <dbname>"
      end
    end
  end
end