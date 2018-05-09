require "json"

module TogglevBot
  class EmployeeFinder
    def initialize(keys)
      @keys = keys
    end

    def users_list
      @keys["users"]
    end
  end
end
