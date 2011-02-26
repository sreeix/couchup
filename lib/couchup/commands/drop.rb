module Couchup
  module Commands
    class Drop
      def run(*params)
        op_type = params.shift.to_s
        (params.first.nil? ? Couchup.database : Couchup.database(params.first)).delete! if op_type == 'database'
        ::Couchup::View.new(params.first).delete! if op_type == 'view'
        Couchup.delete_doc(params.first) if op_type == 'doc'
        Couchup.delete_all_docs(params.first) if op_type == 'all_docs'
        
      end

      def self.describe
        "Drops a either of :database, :view , doc. Use it with drop :database, <dbname> or drop :view, 'Rider/test2', or drop :doc, <id> or even drop :all_docs which removes just the documents"
      end
    end
  end
end