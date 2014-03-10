Gem::Specification.new do |s|
  s.name        = 'typeform'
  s.version     = '0.0.1'
  s.date        = '2014-03-10'
  s.summary     = "Adapter to connect to Typeform API"
  s.description = "Adapter to connect to Typeform API"
  s.authors     = ["Jo Cranford"]
  s.email       = 'jo.cranford@gmail.com'
  s.files       = ["lib/**/*.rb"]
  s.homepage    =
    'http://github.com/jocranford/typeform'
  
  s.add_dependency 'faraday', '~> 0.9.0'
  
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
end