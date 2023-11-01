# frozen_string_literal: true

module TrackingDetection
  def self.tracking_pixel?(node)
    node.attribute('width')&.value == '1' && node.attribute('height')&.value == '1'
  end
end
