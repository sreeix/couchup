# require 'yajl-ruby'
require 'couchrest'
begin
  require 'ap'
rescue LoadError
  puts "'gem install awesome_print' for nicer formatting"
  alias ap puts
end

require  File.expand_path '../couchup/couchup', __FILE__
Dir[File.expand_path('../couchup/commands/*.rb',__FILE__)].each { |file| require file}
Dir[File.expand_path('../couchup/extensions/*.rb',__FILE__)].each { |file| require file}
Dir[File.expand_path('../couchup/*.rb',__FILE__)].each { |file| require file}


Couchup::Commands.constants.each do |c|
  instance_eval "
    def last_result
      Couchup::Couchup.last_result
    end
    alias __ last_result 
    def #{c.underscore}(*args)
      begin
        instance = Couchup::Commands.const_get(:#{c}).new
        Couchup::Couchup.last_result = instance.run(*args)
        nil
      rescue 
        puts $!.class
        ap $!.inspect
        ap $!.backtrace if Couchup::Couchup.debug?
      end
    end"
end
