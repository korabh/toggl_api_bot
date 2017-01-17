# TogglevBot, Mozaix LLC.
require "rake"
require "logger"
require "./lib/togglev_bot"

logger = Logger.new(STDOUT)
logger.level = Logger::WARN
_conf = ConfigFile.new("./config.json").load
users_list = TogglevBot::EmployeeFinder.new(_conf["keys"]).users_list
dropbox = TogglevBot::DropboxWrapper.new(
  "5dN8YtGUfLAAAAAAAAAATOsAyyT6igOADjiFycmLljOSNZCcSxYIwWv4vJSTLlsu"
)
namespace :toggl do
  task :summary do
    dropbox.create_folder("/togglev_bot/#{Date.today.to_s(:db)}")
    users_list.each do |user|
      tglb = TogglevBot::TogglUser.new(user)
      tgr = TogglevBot::ToggleReport.new(user)
      tgr.set_workspace_id(tglb.workspaces.first["id"])
      tgr.write_report(:summary, tglb.toggl_file)
      dropbox.upload(
        "/togglev_bot/#{Date.today.to_s(:db)}/#{tglb.toggl_file}",
        tglb.toggl_file
      )
      FileUtils.rm_rf(tglb.toggl_file)
    end
  end

  task :weekly do
    dropbox.create_folder("/togglev_bot/#{Date.today.to_s(:db)}")
    users_list.each do |user|
      tglb = TogglevBot::TogglUser.new(user)
      tgr = TogglevBot::ToggleReport.new(user)
      tgr.set_workspace_id(tglb.workspaces.first["id"])
      tgr.write_report(:weekly, tglb.toggl_file)
      dropbox.upload(
        "/togglev_bot/#{Date.today.to_s(:db)}/#{tglb.toggl_file}",
        tglb.toggl_file
      )
      FileUtils.rm_rf(tglb.toggl_file)
    end
    twlo = TogglevBot::Twilio.new
    twlo.send_message(
      "Weekly Reports for /#{Date.today.to_s(:db)} https://goo.gl/ctOqsi"
    )
    puts "Weekly Reports for /#{Date.today.to_s(:db)} https://goo.gl/ctOqsi"
  end
end
