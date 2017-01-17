require "dropbox"

module TogglevBot
  class DropboxWrapper
    def initialize(access_token)
      @access_token = access_token
    end

    def upload(fname, toggl_file)
      dropbox.upload(
        fname,
        File.read(toggl_file)
      )
    end

    def create_folder(path)
      dropbox.create_folder(path)
    end

    private

    attr_reader :access_token

    def dropbox
      @dropbox ||=
        Dropbox::Client.new(access_token)
    end
  end
end
