module WritePost
  def write_post
    puts "--" * 30
    puts "Type 0 and press enter to go back to main menu"

    begin
      print "URL: "
      url = gets.strip.downcase

      return if url == '0'
      raise "\nURL should not be empty. Enter again\n\n" if url.empty?
      raise "\nPost with this url already exist! Please use different URL\n\n" if users.any? {|user| user.posts.any? {|post| post.url == url}}

    rescue => e
      puts e
      retry
    end

    begin
      print "Title: "
      title = (gets.strip.split(' ').each {|word| word.capitalize!}).join(' ')

      return if title == '0'
      raise "\nTitle can not be empty. Enter again\n" if title.empty?
      raise "\nPost with this title already exist! Please use different title\n" if all_posts.any? {|post| post.title.downcase == title.downcase}

    rescue => e
      puts e, "\n"
      retry
    end

    begin
      print "Content: "
      content = gets.strip.capitalize
      return if content == '0'
      raise "\nContent can not be empty. Please enter again\n" if content.empty?

    rescue => e
      puts e, "\n"
      retry
    end

    begin
      print "Post tags: "
      tags = gets.strip.downcase
      return if tags == '0'
      raise "\nPost must have tag\n" if tags.empty?

    rescue => e
      puts e, "\n"
      retry
    end

    post = Post.new(url, title, content, logged_user.username, tags.delete(' ').split(','))
    logged_user.posts << post
    set_all_posts(post)

    puts "\nPost published successfully!\n"

    logged_user.followers.each {|follower|
      notifications(follower,"#{logged_user.username} published a new post.")
    }

    puts "\nPress Enter to go back to main menu"
    exit = gets
    return
  end
end

