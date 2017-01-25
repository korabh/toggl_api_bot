# config/schedule.rb
require "tzinfo"

def local(time)
  TZInfo::Timezone.get('Europe/Berlin').local_to_utc(Time.parse(time))
end

every :weekday, :at => local("11:55pm") do
  rake "toggl:summary"
end

every :sunday, :at => local("11:55pm") do
  rake "toggl:weekly"
end
