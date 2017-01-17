require "active_support/all"

module TogglevBot
  class ToggleReport < TogglBase
    def initialize(api_token)
      @api_token = api_token
      super
    end

    def write_report(type, fname, **options)
      case type
      when :summary
        reports.write_summary(fname, options)
      when :weekly
        reports.write_weekly(fname, options)
      end
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
