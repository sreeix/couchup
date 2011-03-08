require 'rubygems'
require 'bundler/setup'

require 'json'
ROOT = File.expand_path("../..", __FILE__)
$LOAD_PATH.unshift(File.join(ROOT, "lib"))
require 'couchup'


# Spec stuff
require 'awesome_print'
require 'couchrest'

HOST = ENV['HOST'] || "127.0.0.1"
PORT = ENV['PORT'] || "5984"

TEST_DATABASE = 'couchup_test'

def database
  @db ||= CouchRest.database("http://#{HOST}:#{PORT}/#{TEST_DATABASE}")
end

RSpec.configure do |config|
  config.before(:all) do 
    begin
      database.delete! 
      database.create!
      Couchup::Couchup.host = HOST
      Couchup::Couchup.port = PORT
      Couchup::Couchup.database = TEST_DATABASE
    rescue
      ap "Looks like the couch db does not exist. Use HOST and or PORT env param to set the couchdb server"
    end
  end
end


