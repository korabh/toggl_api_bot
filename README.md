# togglev_bot

# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
every :weekday, :at => "11:55pm" do
  rake "toggl:summary"
end

every :sunday, :at => '11:55pm' do
  rake "toggl:weekly"
end
