module TogglevBot
  class WorkBook
    def initialize
      @config = ConfigFile.new("./config.json").load
      @employees = TogglevBot::EmployeeFinder.new(@config["keys"]).users_list
    end

    def generate(job_type, from:, to:)
      @dbx = TogglevBot::DropboxWrapper.new(
        "5dN8YtGUfLAAAAAAAAAATOsAyyT6igOADjiFycmLljOSNZCcSxYIwWv4vJSTLlsu"
      )
      dirname = case job_type
                when :summary
                  "/togglev_bot/Summary-#{from}"
                when :weekly
                  "/togglev_bot/Weekly-#{from}-#{to}"
                end
      @dbx.create_folder(dirname)
      @employees.each do |employee_id|
        tglb = TogglevBot::TogglUser.new(employee_id)
        tgr = TogglevBot::ToggleReport.new(employee_id)
        tgr.set_workspace_id(tglb.workspaces.first["id"])
        tgr.write_report(tglb.toggl_file, since: from, until: to)
        @dbx.upload(
          "#{dirname}/#{tglb.toggl_file}",
          tglb.toggl_file
        )

        FileUtils.rm_rf(tglb.toggl_file)
      end
      twlo = TogglevBot::Twilio.new
      twlo.send_message(
        "Boss, Please review #{job_type.to_s} reports at https://goo.gl/ctOqsi. Toggle Bot.<3"
      )
    end

  end
end

