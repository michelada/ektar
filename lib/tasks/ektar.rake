namespace :ektar do
  desc "Installs migrations, deps with yarn and compiles assets"
  task :setup do
    puts "Complete ektar setup"
    puts "Installing migrations"
    Rake::Task["ektar:install:migrations"].invoke
    Rake::Task["ektar:yarn_setup"].invoke
  end

  desc "Installs dependencies with yarn and compiles assets"
  task :yarn_setup do
    puts "Installing dependencies with yarn"
    Rake::Task["ektar:webpacker:yarn_install"].invoke

    puts "Compiling assets"
    Rake::Task["ektar:webpacker:compile"].invoke
  end
end
