module TogglevBot
  class TogglUser < TogglBase
    def initialize(api_token)
      @api_token = api_token
      super
    end

    def create_entry(**options)
      toggl.create_entry(options)
    end

    def user
      toggl.me
    end

    def workspaces
      toggl.my_workspaces(user)
    end
  end

end
