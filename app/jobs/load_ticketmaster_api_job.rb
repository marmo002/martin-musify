class LoadTicketmasterApiJob < ApplicationJob
  queue_as :default

  def perform

    TicketmasterAPI.new.create_db

  end

end
