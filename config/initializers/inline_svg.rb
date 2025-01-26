# frozen_string_literal: true

require 'inline_svg/vite_file_loader'

InlineSvg.configure do |config|
  config.asset_file = InlineSvg::ViteFileLoader
  config.raise_on_file_not_found = Rails.env.test?
end
