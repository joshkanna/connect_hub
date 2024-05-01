# -*- encoding: utf-8 -*-
# stub: pgreset 0.4 ruby lib

Gem::Specification.new do |s|
  s.name = "pgreset".freeze
  s.version = "0.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Dan Falcone".freeze]
  s.bindir = "exe".freeze
  s.date = "2023-10-12"
  s.description = "Kills postgres connections during db:reset so you don't have to restart your server.  Fixes \"database in use\" errors.".freeze
  s.email = ["danfalcone@gmail.com".freeze]
  s.homepage = "https://github.com/dafalcon/pgreset".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.3.26".freeze
  s.summary = "Automatically kill postgres connections during db:reset".freeze

  s.installed_by_version = "3.3.26" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<bundler>.freeze, ["~> 2.2.4"])
    s.add_development_dependency(%q<rake>.freeze, ["~> 13.0.3"])
  else
    s.add_dependency(%q<bundler>.freeze, ["~> 2.2.4"])
    s.add_dependency(%q<rake>.freeze, ["~> 13.0.3"])
  end
end
