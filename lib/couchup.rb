require  File.expand_path '../couchup/couchup', __FILE__
Dir[File.expand_path('../couchup/commands/*.rb',__FILE__)].each { |file| require file}
Dir[File.expand_path('../couchup/extensions/*.rb',__FILE__)].each { |file| require file}


Commands.constants.each do |c|
  instance_eval "
    def #{c.underscore}(*args)
      begin
        instance = Commands.const_get(:#{c}).new
        instance.run(*args)
      rescue 
        puts $!.inspect
      end
    end"
end

puts "Type help to view the list of things you can do. And Yeah Relax."



