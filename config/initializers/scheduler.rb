require 'rufus-scheduler'

# Let's use the rufus-scheduler singleton
#
s = Rufus::Scheduler.singleton

s.every '6h' do
    LoadTicketMasterApi.perform_now
end