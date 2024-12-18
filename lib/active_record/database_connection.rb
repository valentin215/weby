require 'sqlite3'
require 'singleton'

module ActiveRecord
  class DatabaseConnection
    include Singleton

    def initialize
      @database = SQLite3::Database.new(':memory:')
      @database.results_as_hash = true
    end

    def execute(*args)
      @database.execute(*args)
    end
  end
end
