module Couchup
  module Commands
    class Compact
      def run(*params)
        Couchup.database.compact!
      end
      def self.describe
        "Compacts the database. To preserve space"
      end
    end
  end
end