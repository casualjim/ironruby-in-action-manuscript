require 'activerecord/fixtures'
class GenerateData < ActiveRecord::Migration
  def self.up
    puts RAILS_ROOT + '/db/fixtures/testing.yml'
  end

  def self.down
  end
end
