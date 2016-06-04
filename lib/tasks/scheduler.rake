desc "This task will start the telegram ma-mensa bot"
task :update_feed => :environment do
  puts "Starting bot."
  BotWorker.perform
end
