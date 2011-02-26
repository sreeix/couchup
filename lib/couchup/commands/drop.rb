module Couchup
  module Commands
    class Drop
      def run(*params)
        op_type = params.shift.to_s
        (params.first.nil? ? Couchup.database : Couchup.database(params.first)).delete! if op_type == 'database'
        ::Couchup::View.new(params.first).delete! if op_type == 'view'
        ::Couchup::View.new(params.first).delete! if op_type == 'doc'
        Couchup.delete_doc(params.first)  
      end

      def self.describe
        "Drops a either of :database, :view , doc. Use it with drop :database, <dbname> or drop :view, 'Rider/test2', or drop :doc, <id>"
      end
    end
  end
end