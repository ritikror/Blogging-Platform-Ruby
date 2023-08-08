require_relative './class/class_post'
require_relative './class/class_comment'
require_relative './class/class_user'
require_relative './modules/module_registeration.rb'
require_relative './class/class_main_menu'
require_relative './modules/module_login'
require_relative './modules/module_list_main.rb'

class Main
  extend Registration
  extend Login
  extend ListMain

  @users = []

  def self.initialize_already_exist_user
    @users.each { |line|
      line_arr = line.strip.split('=')
      @users << User.new(line_arr[0],line_arr[1],line_arr[2])
    }
  end
end

catch :exit do
  Main.initialize_already_exist_user
  Main.list_main
end

puts "\n", "Exiting....";
puts "Thank you for visiting Myblog.com", "==" * 30, "\n"
