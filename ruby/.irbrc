%w{rubygems wirble awesome_print}.each do |lib| 
    begin 
      require lib 
    rescue LoadError => err
      $stderr.puts "Couldn't load #{lib}: #{err}"
    end
  end

%w{init colorize}.each { |str| Wirble.send(str) }
AwesomePrint.irb!
