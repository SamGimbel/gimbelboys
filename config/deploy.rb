# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'gimbelboys'
set :repo_url, '_site'
set :deploy_via, :copy
set :copy_compression, :gzip
set :use_sudo, false
set :user, "samgimbel"
set :deploy_to, "/home/samgimbel/gimbelboys"
set :stages, ["production"]
set :default_stage, "production"
role :web, "104.131.85.108"

before 'deploy:update', 'deploy:update_jekyll'

namespace :deploy do
  [:start, :stop, :restart, :finalize_update].each do |t|
    desc "#{t} task is a no-op with jekyll"
    task t, :roles => :app do ; end
  end

  desc "Run jekyll to update site before uploading"
  task :update_jekyll do
    # clear existing _site
    # build site using jekyll
    # remove Capistrano stuff from build
    %x(rm -rf _site/* && jekyll build && rm _site/Capfile && rm -rf _site/config)
  end
end
