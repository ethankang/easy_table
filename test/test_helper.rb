require 'rubygems'
require 'bundler/setup'

require 'test/unit'
require 'mocha'
require 'shoulda-context'

require 'active_model'
require 'action_controller'
require 'action_view'
require 'action_view/template'

# Rails 3.0.4 is missing this "deprecation" require.
require 'active_support/core_ext/module/deprecation'
require 'action_view/test_case'

module Rails
  def self.env
    ActiveSupport::StringInquirer.new("test")
  end
end

$:.unshift File.expand_path("../../lib", __FILE__)
require 'easy_table'

Dir["#{File.dirname(__FILE__)}/support/*.rb"].each do |file|
  require file
end
I18n.default_locale = :en

ActionDispatch::Assertions::NO_STRIP << "label"

class ActionView::TestCase
  include EasyTable::ActionViewExtensions::TableHelper

  setup :set_controller

  def set_controller
    @controller = MockController.new
  end

  def protect_against_forgery?
    false
  end
end