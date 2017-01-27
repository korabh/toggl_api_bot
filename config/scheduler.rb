require "rufus-scheduler"

scheduler = Rufus::Scheduler.new

scheduler.in '3s' do
  puts 'Hello... Rufus'
end

# scheduler.cron '5 23 * * * Europe/Berlin' do
#   rake "toggl:summary"
# end
#
# scheduler.cron('00 12 * * sun#-1 Europe/Berlin') do
#   rake "toggl:weekly"
# end

scheduler.join
