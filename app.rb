require "active_support/all"
require "togglv8"
require "json"
require "dropbox"
require "twilio-ruby"

# togglev_bot:
# [x] Fetch employees workspaces from toggl_api.
# [x] Store files on dropbox folder.
# [x] Create a new toggl create time entry.
# [x] Send e-mail to owners to check the latest timesheet.

# Config file.
config = {
  keys: {
    users: [
      "06fd756e24934c9d88c1c86bdffd9ff2",
      "23d9e809bdeb68205033291df22dc50c"
    ]
  }
}

cmp_list = []

dbx = Dropbox::Client.new("5dN8YtGUfLAAAAAAAAAATOsAyyT6igOADjiFycmLljOSNZCcSxYIwWv4vJSTLlsu")
dbx.create_folder("/togglev_bot/#{Date.today.to_s(:db)}")

config[:keys][:users].each do |key|
  toggl = TogglV8::API.new(key)
  me = toggl.me
  my_workspaces = toggl.my_workspaces(me)

  # Set toggl workspace id
  reports = TogglV8::ReportsV2.new(api_token: key)
  reports.workspace_id = my_workspaces.first["id"]

  # Generate Daily .pdf report
  fname = "toggl_#{Date.today.to_s(:db)}_#{me['fullname'].split(' ').join('_').downcase}.pdf"
  reports.write_summary(
    fname, since: Date.today.to_s(:db), until: Date.today.to_s(:db)
  )
  cmp_list.push(fname)
end
# l_dir = FileUtils.mkdir(Date.today.to_s(:db))
# FileUtils.mv(cmp_list, l_dir)
puts "employees: #{cmp_list.split(' ')}"

cmp_list.each do |file|
  dbx.upload("/togglev_bot/#{Date.today.to_s(:db)}/#{file}", File.read(file))
end
puts "Added to dropbox.com"

# https://www.dropbox.com/sh/oh2s1mcknat6gqk/AAC7YByKtCk0wQ-64dMiWHqFa?dl=0
toggl_api = TogglV8::API.new("06fd756e24934c9d88c1c86bdffd9ff2")
user         = toggl_api.me(all=true)
workspaces   = toggl_api.my_workspaces(user)
workspace_id = workspaces.first['id']
toggl_api.create_time_entry({
  'description' => "Detailed Reports for /#{Date.today.to_s(:db)} https://goo.gl/ctOqsi",
  'wid' => workspace_id,
  'duration' => 0,
  'start' => toggl_api.iso8601((Time.now - 3600).to_datetime),
  'created_with' => "togglev_bot"
})

puts "New time entry for #{user["fullname"]} created."

twilio = Twilio::REST::Client.new "ACa5eac09ec84d0ab8565e4d1af98e724a", "1480787fefaa9f2c015725b0355a1b7c"
twilio.messages.create(
  from: "+16178588544",
  to: "+37744690739",
  body: "Detailed Reports for /#{Date.today.to_s(:db)} https://goo.gl/ctOqsi"
)
puts "Sms sent to #{user["fullname"]}."

# Remove created toggl files
FileUtils.rm_rf(cmp_list)

