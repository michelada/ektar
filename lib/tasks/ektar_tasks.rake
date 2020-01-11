namespace :ektar do
  namespace :webpacker do
    desc "Cleans the Webpack output folder (public/ektar-packs)"
    task :clean_webpack_output_folder do
      puts "Destroying packs output folder ..."
      Dir.chdir(File.join(__dir__, "..", "..")) do
        # TODO : Load packs output from config/webpacker.yml
        system "rm -rf public/ektar-packs"
      end
    end

    desc "Install deps with yarn"
    task :yarn_install do
      Dir.chdir(File.join(__dir__, "..", "..")) do
        system "yarn install --no-progress --production"
      end
    end

    desc "Compile JavaScript packs using webpack for production with digests"
    task :compile do #: [:clean_webpack_output_folder, :yarn_install, :environment] do
      Webpacker.with_node_env("production") do
        if Ektar.webpacker.commands.compile
          # "Successful compilation!"
        else
          # "Failed compilation"
          exit!
        end
      end
    end
  end
end
