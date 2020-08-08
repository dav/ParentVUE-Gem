# frozen_string_literal: true

require_relative 'lib/parentvue'
require 'thor'
require 'pp'

class ParentVUEScript < Thor
  class_option :login_url, aliases: '-l', desc: 'Login Page URL', default: 'https://portal.sfusd.edu/PXP2_Login.aspx'
  class_option :username,  aliases: '-U', desc: 'Username', required: true
  class_option :password,  aliases: '-P', desc: 'Password', required: true
  # TODO: language switch

  desc 'list', 'Print list of students associated with your account.'

  def list
    pp service.students
  end

  private

  def service
    return @service if @service

    @service = ParentVUE::Service.new(options)
    @service.parent_sign_in options[:username], options[:password]

    return @service
  end
end

ParentVUEScript.start(ARGV)
