
desc "This task calls the Ticketmaster API"
task :create_or_update_db => :environment do
    require "#{Rails.root}/app/models/concerns/ticketmaster_api.rb"
    TicketmasterAPI.new.create_db
end
