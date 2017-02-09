module ApiHelper
  class << self
    attr_reader :login, :token

    def load_credentials
      File.open("#{__dir__}/../../credentials.yml", 'r') do |f|
        file = YAML.load(f.read)
        @login, @token = file['login'], file['token_hash'].pack('C*')
      end
    end
  end
end
