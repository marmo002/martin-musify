require 'rufus-scheduler'

# Let's use the rufus-scheduler singleton
#
s = Rufus::Scheduler.singleton

s.every '6h' do
    LoadTicketMasterApiJob.perform_now
end