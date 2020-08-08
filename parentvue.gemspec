Gem::Specification.new do |s|
  s.name        = 'parentvue'
  s.version     = '0.1.0'
  s.date        = '2010-04-28'
  s.summary     = 'For programmatic access to the ParentVUE website'
  s.description = 'Provides a web scraping library to interact with the ParentVUE website'
  s.authors     = ["Dav Yaginuma"]
  s.email       = 'dav@akuaku.org'
  s.files       = %w(lib/parentvue.rb lib/parentvue/service.rb)
  s.homepage    =
    'https://github.com/dav/ParentVUE-Gem'
  s.license       = 'MIT'
  s.require_paths = %w(lib)
  s.bindir = "bin"
  s.executables = %w(parentvue)
  s.add_runtime_dependency 'mechanize', '~> 2.7'
  s.add_runtime_dependency 'thor', '~> 1.0'
  s.add_development_dependency('bundler', '~> 2.1')
end
