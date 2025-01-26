# frozen_string_literal: true

require 'open-uri'

module InlineSvg
  class ViteFileLoader
    def self.named(filename)
      path = ViteRuby.instance.manifest.path_for(filename)

      return fetch_from_dev_server(path) if ViteRuby.instance.dev_server_running?

      Rails.public_path.join(path[1..]).read
    end

    def self.fetch_from_dev_server(path)
      config = ViteRuby.config

      path = "#{config.protocol}://#{config.host_with_port}#{path}"

      # rubocop:disable Security/Open
      # This is only used in dev to load an inline SVG, so security implications are very limited.
      URI.open(path)
      # rubocop:enable Security/Open
    end
  end
end
