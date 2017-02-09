module ApiHelper
  class << self
    attr_reader :login, :repo, :token

    def load_credentials
      File.open("#{__dir__}/../../credentials.yml", 'r') do |f|
        file = YAML.load(f.read)
        @login, @repo, @token = file['login'], file['repo'], file['token_hash'].pack('C*')
      end
    end
  end
end
