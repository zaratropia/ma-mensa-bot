namespace :telegram_bot do
  desc "This task will start the telegram ma-mensa bot"
  task :start => :environment do
    puts "Starting bot."
    BotWorker.perform
  end
end
