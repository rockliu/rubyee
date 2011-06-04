set :application,'rubyee'

set :repository,  "git@github.com:rockliu/rubyee.git"
#set :deploy_to 

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "www.rubyee.net"                          # Your HTTP server, Apache/etc
role :app, "www.rubyee.net"                          # This may be the same as your `Web` server
role :db,  "www.rubyee.net", :primary => true # This is where Rails migrations will run

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

# namespace :deploy do
#   task :start {}
#   task :stop {}
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end
