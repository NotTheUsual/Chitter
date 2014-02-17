env = ENV['RACK_ENV'] || "development"

# ENV['DATABASE_URL'] is for Heroku
# DataMapper.setup(:default, ENV['DATABASE_URL'] || 'postgres://cdfdljcxdxfeoj:EoumGPuhYfU5qsDlRj1q4PzCsu@ec2-54-204-36-244.compute-1.amazonaws.com:5432/d19oe3hvks87i8')
DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/bookmark_manager_#{env}")

Dir.glob(File.join(File.dirname(__FILE__), 'models', '*.rb'), &method(:require))

DataMapper.finalize
DataMapper.auto_upgrade!