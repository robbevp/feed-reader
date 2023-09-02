# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'

# Clear existing coverage assets due to https://github.com/simplecov-ruby/simplecov/issues/741
Pathname.new(__FILE__).join('../../coverage/assets').tap { |cov| FileUtils.rm_rf cov if cov.exist? }

require 'simplecov'
SimpleCov.start 'rails' do
  enable_coverage :branch
  add_filter 'vendor'
  add_group 'Components', 'app/components'
  add_group 'Policies', 'app/policies'
end

if ENV['CI'].present? && ENV['SKIP_CODECOV'].blank?
  require 'simplecov-cobertura'
  SimpleCov.formatter = SimpleCov::Formatter::CoberturaFormatter
end

require_relative '../config/environment'
require 'rails/test_help'
require 'faker'
require 'webmock/minitest'

class ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods

  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  parallelize_setup do |worker|
    SimpleCov.command_name "#{SimpleCov.command_name}-#{worker}"
  end

  parallelize_teardown do |_worker|
    SimpleCov.result
  end

  teardown do
    Faker::UniqueGenerator.clear
  end
end

module SessionHelper
  def sign_in(user)
    # NOTE: We currently sent a request to get the proper cookies back, but maybe we can fake/mock this in some way?
    post sign_in_url, params: { session: { email: user.email, password: user.password } }
  end

  def sign_out
    integration_session.cookies[:participant_id] = nil
  end
end

class ActionDispatch::IntegrationTest
  include SessionHelper
end

module FormComponentsHelper
  def form_with(object, **opts)
    lookup_context = ActionView::LookupContext.new(ActionController::Base.view_paths)
    template = ActionView::Base.new(lookup_context, {}, ApplicationController.new)
    object_name = object.respond_to?(:model_name) ? object.model_name.param_key : :user
    ComponentFormBuilder.new(object_name, object, template, opts)
  end
end
