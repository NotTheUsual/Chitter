env = ENV['RACK_ENV'] || "development"

# ENV['DATABASE_URL'] is for Heroku
#  || "postgres://localhost/bookmark_manager_#{env}"
DataMapper.setup(:default, ENV['DATABASE_URL'])

Dir.glob(File.join(File.dirname(__FILE__), 'models', '*.rb'), &method(:require))

DataMapper.finalize
DataMapper.auto_upgrade!