env = ENV['RACK_ENV'] || "development"

# ENV['DATABASE_URL'] is for Heroku
DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/bookmark_manager_#{env}")

Dir.glob(File.join(File.dirname(__FILE__), 'models', '*.rb'), &method(:require))

DataMapper.finalize
DataMapper.auto_upgrade!