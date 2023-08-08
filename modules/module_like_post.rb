module LikePost
  def like_post(post)
    if post.like_by.include?(logged_user.username)
      begin
        puts "\nYou already liked the post\n"
        puts "0. To go back"
        puts "1. To unlike the post"
        print "Enter your choice: "
        input_like = gets.strip

        raise "\nPlease enter valid option\n" unless input_like.match(/\A[0-1]\z/)
        return if input_like == '0'

        post.like_by.delete(logged_user.username)
        puts "\n-------Unliked---------"
      rescue => e
        puts e
        retry
      end
    else
      post.add_like_by (logged_user.username)
      puts "\nYou have liked the post"
      notifications(post.author,"#{logged_user.username} liked your post. Post url is #{post.url}") if logged_user.username != post.author
    end
  end

  def post_liked_by(post)
    return puts "\nNo likes on this post\n" if post.like_by.empty?
    print "\nLikes: #{post.like_by.length} "
    post.like_by.each {|liked_by| print "(#{liked_by}) "}

    print "\n\nPress enter to go back"
    exit = gets
    return
  end
end
