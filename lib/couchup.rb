require  File.expand_path '../couchup/couchup', __FILE__
Dir[File.expand_path('../couchup/commands/*.rb',__FILE__)].each { |file| require file}

