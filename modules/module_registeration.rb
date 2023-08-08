module Registration
    def registration
      puts "\n" + "--" * 5 + "Registration" + "--" * 5 + "\n"
      puts "Type 0 and press enter to go back."
  
      begin
        print "Please enter your username: "
        username = gets.strip.downcase
        return if username == '0'
        raise "\nInvalid username!! enter again-\n\n" if !username.match(/\A[a-z][a-z0-9_]{3,9}\z/)
        raise "\nUsername already exists! Please use a different username\n\n" if @users.any? { |user| user.username == username }
  
      rescue => e
        puts e
        retry
      end
  
      begin
        print "Please enter your email: "
        email = gets.strip.downcase
        return if email == '0'
        raise "\nInvalid E-mail id!! enter again-\n\n" if !email.match(/\A[a-z][\w\d+\-.]+@[\w\d\-]+\.[a-z]{2,3}\z/)
        raise "\nUser already exists with this email! Please use a different Email\n\n" if @users.any? { |user| user.email == email }

      rescue => e
        puts e
        retry
      end
  
      begin
        print "Please enter your password: "
        password = gets.strip
          
        return if password == '0'
        raise "\n\nA password must be min 5 and max 10 characters long.\n\n" if !(password.match(/\A.{5,10}\z/))
      rescue => e
        puts e
        retry
      end
  
      # Add the user to the @users array
      @users << User.new(username, email, password)
  
      puts "\n\n", "Registration successful!! Please proceed to login.\n"
    end
  end