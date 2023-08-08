require_relative '../modules/module_write_post.rb'
require_relative '../modules/module_display_posts'
require_relative '../modules/module_search_post'
require_relative '../modules/module_follow_unfollow'
require_relative '../modules/module_dashboard'
require_relative '../modules/module_posts'
require_relative '../modules/module_notification'
require_relative '../modules/module_post_options'
require_relative '../modules/module_like_post'
require_relative '../modules/module_comment'
require_relative '../modules/module_list_followers_following'


class MainMenu
  attr_accessor :logged_user, :users

  def initialize(users,logged_user)
    @users = users
    @logged_user = logged_user
    @all_posts = []

    users.each {|user|
      @all_posts += user.posts if !user.posts.empty?
    }
  end

  include WritePost
  include DisplayPosts
  include SearchPost
  include FollowUnfollowUser
  include Dashboard
  include MyPost
  include Notification
  include PostOptions
  include LikePost
  include CommentOnPost
  include ListFollowersFollowing

  def set_all_posts (post)
    @all_posts << post
  end

  def all_posts
    return @all_posts
  end

  def show_main_menu
    while true do
      puts "--" * 30
      puts "Welcome #{logged_user.username} in MyBlog.com"
      puts "1. Write a Post"
      puts "2. Display Posts"
      puts "3. Search Posts"
      puts "4. Follow/unfollow User"
      puts "5. My Posts"
      puts "6. Display Followers/Following"
      puts "7. My DashBoard"
      puts "8. Log Out"
      puts "9. Exit"
      print "Please enter your choice: "

      main_input = gets.strip

      unless main_input.match(/\A[1-9]\z/)
        puts "\nPlease enter valid input\n\n"
        redo
      end

      case main_input.to_i
      when 1
        write_post
      when 2
        display_posts
      when 3
        search_post
      when 4
        follow_unfollow_user
      when 5
        my_posts
      when 6
        list_followers_following
      when 7
        my_dashboard
      when 8
        puts "\nLogged out!!\n"
        return
      when 9
        throw :exit;
      end
    end
  end
end
