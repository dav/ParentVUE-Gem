# frozen_string_literal: true

require 'mechanize'

module ParentVUE
  class Service
    attr_reader :mechanize
    attr_reader :base_url
    attr_reader :students

    def initialize(options = {})
      @mechanize = Mechanize.new

      @login_url = options[:login_url]

      uri = URI.parse(@login_url)
      @base_url = "#{uri.scheme}://#{uri.host}"
    end

    def main_login_page
      @mechanize.get(@login_url)
    end

    def parent_sign_in(username, password)
      parent_login_link = main_login_page.link_with(text: /ParentVUE/)
      login_page = parent_login_link.click

      post_login_page = login_with_credentials(login_page, username, password)

      return false if post_login_page.at '#ctl00_USER_ERROR'

      scrape_students(post_login_page)

      return post_login_page
    end

    private

    def login_with_credentials(parent_login_page, username, password)
      login_form = parent_login_page.form('aspnetForm')
      login_form['ctl00$MainContent$username'] = username
      login_form['ctl00$MainContent$password'] = password
      @mechanize.submit(login_form, login_form.buttons.first)
    end

    def scrape_students(home_page)
      @students = []
      home_page.search('div.student-info').each do |element|
        student_id = element.search('span.student-id').text
        student_id.slice! 'ID: '

        @students << {
          name: element.search('span.student-name').text,
          id: student_id,
          school_name: element.search('div.school').text
        }
      end
    end
  end
end
