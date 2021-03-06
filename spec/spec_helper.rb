require 'rubygems'
require 'rspec'
require 'active_record'
require "carrierwave"
require 'carrierwave/orm/activerecord'
require 'carrierwave/processing/mini_magick'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require "carrierwave-upyun"

module Rails
  class <<self
    def root
      [File.expand_path(__FILE__).split('/')[0..-3].join('/'),"spec"].join("/")
    end
  end
end

ActiveRecord::Migration.verbose = false

# 测试的时候需要修改这个地方
CarrierWave.configure do |config|
  config.storage = :upyun
  config.upyun_username = ENV['upyun_username'] || "test"
  config.upyun_password = ENV['upyun_password'] || '123123'
  config.upyun_bucket = ENV['upyun_bucket'] || "ruby-china-files-dev"
  config.upyun_bucket_host = ENV['upyun_bucket_host'] || "http://ruby-china-files-dev.b0.upaiyun.com"
end

def load_file(fname)
  File.open([Rails.root,fname].join("/"))
end
