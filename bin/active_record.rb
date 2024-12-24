#!/usr/bin/env ruby
require_relative '../lib/active_record'

# Database Setup and Record Insertion
ActiveRecord::DatabaseConnection.instance.execute(<<-SQL)
  CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    name TEXT,
    organization TEXT,
    active BOOLEAN,
    created_at DATETIME
  );
SQL

alice_values = ['Alice', 'RubyCademy', 1, '2023-03-01']
bob_values = ['Bob', 'OtherOrg', 0, '2023-02-01']
charlie_values = ['Charlie', 'RubyCademy', 1, '2022-02-01']
schema = 'INSERT INTO users (name, organization, active, created_at) VALUES (?, ?, ?, ?)'

ActiveRecord::DatabaseConnection.instance.execute(schema, alice_values)
ActiveRecord::DatabaseConnection.instance.execute(schema, bob_values)
ActiveRecord::DatabaseConnection.instance.execute(schema, charlie_values)

class User < ActiveRecord::Base
  def self.active
    where(active: 1)
  end
end

# Query Example
puts User.where(organization: 'RubyCademy').active.count
puts User.active.where(organization: 'RubyCademy').to_a

# Execution
# chmod +x bin/active_record.rb
# .bin/active_record.rb

# Output
# Executing SQL: SELECT COUNT(*) FROM users WHERE organization = 'RubyCademy' AND active = '1'
# 2
# Executing SQL: SELECT * FROM users WHERE active = '1' AND organization = 'RubyCademy'
# {"id"=>1, "name"=>"Alice", "organization"=>"RubyCademy", "active"=>1, "created_at"=>"2023-03-01"}
# {"id"=>3, "name"=>"Charlie", "organization"=>"RubyCademy", "active"=>1, "created_at"=>"2022-02-01"}
