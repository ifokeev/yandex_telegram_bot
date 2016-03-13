namespace :bot do
  task :start_listen => :environment do
    puts 'Starting bot'

    TelegramBot::Client.start_listen
  end

  task :stop_listen => :environment do
    puts 'Stoping bot'

    TelegramBot::Client.stop_listen
  end
end
