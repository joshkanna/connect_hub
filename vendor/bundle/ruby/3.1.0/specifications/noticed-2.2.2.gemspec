# -*- encoding: utf-8 -*-
# stub: noticed 2.2.2 ruby lib

Gem::Specification.new do |s|
  s.name = "noticed".freeze
  s.version = "2.2.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Chris Oliver".freeze]
  s.date = "2024-03-21"
  s.description = "Database, browser, realtime ActionCable, Email, SMS, Slack notifications, and more for Rails apps".freeze
  s.email = ["excid3@gmail.com".freeze]
  s.homepage = "https://github.com/excid3/noticed".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.3.26".freeze
  s.summary = "Notifications for Ruby on Rails applications".freeze

  s.installed_by_version = "3.3.26" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<rails>.freeze, [">= 6.1.0"])
  else
    s.add_dependency(%q<rails>.freeze, [">= 6.1.0"])
  end
end
