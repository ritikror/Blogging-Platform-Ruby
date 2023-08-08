module Login
    def login
  
      puts "\n", "--" * 5 + " Login " + "--" * 5, "\n"
      puts "Type 0 and press enter to go back."
  
      begin
        print "Please enter your username/e-mail: "
        username_email = gets.strip.downcase
        return [false] if username_email == '0'
        raise "\n\nUsername/e-mail should not be empty! enter again-\n\n" if username_email.empty?
      rescue => e
        puts e
        retry
      end
  
      begin
        print "Please enter your password: "
        password = gets.strip
        return [false] if password == '0'
  
        raise "\n\nPassword should not be empty! enter again-\n\n" if password.empty?
      rescue => e
        puts e
        retry
      end
  
      logged_user = @users.find { |user| (user.username == username_email || user.email == username_email) && user.password == password }
  
      if logged_user
        puts "\n\nLogin successful! Welcome, #{logged_user.username}!\n";
        return [true, MainMenu.new(@users, logged_user)]
      else
        puts "\n\n", "Please enter a valid username or password."
        puts "If you have not registered before, please register first!\n"
        return [false]
      end
    end
  end
