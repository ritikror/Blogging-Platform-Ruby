module SearchPost
  def search_post
    begin
      puts "--" * 30
      puts "1. Search for post "
      puts "2. Go back to main menu"
      print "Please enter your choice: "
      search_choice = gets.strip

      raise "\nPlease enter valid option\n\n" unless search_choice.match(/\A[1-3]\z/)

      case search_choice.to_i
        when 1
          searching
          raise ""
        when 2
          return
      end

    rescue => e
      puts e
      retry
    end
  end

  def searching
    begin
      puts "\n", "--" * 30
      puts "Type 0 and enter to go back"
      print "Enter post title or tag: "
      search_input = gets.strip.downcase

      return if search_input == '0'
      raise "\nInvalid title!! please enter again!" if search_input.empty?

    rescue => e
      puts e
      retry
    end

    not_found = true

    all_posts.each {|post|
      if post.title.downcase.include?(search_input) || post.content.downcase.include?(search_input) || post.tags.include?(search_input)
        puts "--" * 30
        puts "URL: #{post.url}"

        if post.author == logged_user.username
          post.author= "You (#{logged_user.username})"
          post.display_post
          post.author= "#{logged_user.username}"
        else
          post.display_post
        end

        not_found = false

      end
    }

    return puts "\nNot found any post with this title\n" if not_found

    begin
      puts "\n","--" * 30
      puts "Type 0 and enter to go back"
      print 'Enter post URL to select: '
      post_url = gets.strip.downcase
      post = all_posts.find {|post| post.url == post_url}

      return if post_url == '0'

      raise "\nPlease enter valid URL\n" if post == nil

    rescue => e
      puts e
      retry
    end

    post_options(post)

  end 
end
