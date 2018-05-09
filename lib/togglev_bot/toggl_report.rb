require "active_support/all"

module TogglevBot
  class ToggleReport < TogglBase
    def initialize(api_token)
      @api_token = api_token
      super
    end

    def write_report(fname, **options)
      reports.write_summary(fname, options)
    end

    def set_workspace_id(id)
      reports.workspace_id = id
    end

    private

    def reports
      @reports ||= TogglV8::ReportsV2.new(api_token: api_token)
    end
  end
end
