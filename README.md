togglev_bot

```
require "rufus-scheduler"

scheduler = Rufus::Scheduler.new

# +---------------- minute (0 - 59)
# |  +------------- hour (0 - 23)
# |  |  +---------- day of month (1 - 31)
# |  |  |  +------- month (1 - 12)
# |  |  |  |  +---- day of week (0 - 6) (Sunday=0 or 7)
# |  |  |  |  |
#   *  *  *  *  *  command to be executed 
scheduler.cron '50 23 * * * Europe/Belgrade' do
  rake "toggl:summary"
end

scheduler.cron('50 23 * * 0 Europe/Belgrade') do
  rake "toggl:weekly"
end

scheduler.join
```

Puntoria Inc. 2018
