require 'rails_helper'

RSpec.describe Api::V1::UrlsController, type: :routing do
  describe 'routing' do
    it 'routes to #encode' do
      expect(post: '/api/v1/urls/encode').to route_to('api/v1/urls#encode')
    end

    it 'routes to #decode' do
      expect(post: '/api/v1/urls/decode').to route_to('api/v1/urls#decode')
    end
  end
end
