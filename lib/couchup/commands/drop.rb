module Couchup
  module Commands
    class Drop
      def run(*params)
        op_type = params.shift.to_s
        (params.first.nil? ? Couchup.database : Couchup.new_database(params.first)).delete! if op_type == 'database'
        ::Couchup::View.new(params.first).delete! if op_type == 'view'
        Couchup.delete_doc(params.first) if op_type == 'doc'
        Couchup.delete_all_docs(params.first) if op_type == 'all_docs'
        
      end

      def self.describe
        {
          :description => "Drops specified object from couchdb",
          :usage => "drop [:database | :view | :doc | :all_docs]",
          :examples => ["drop :database, 'test'", "drop :view, 'Riders/top_ten'", "drop :doc, '23'", "drop :all_docs"]
        }
      end
    end
  end
end