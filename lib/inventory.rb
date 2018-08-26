# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "yaml"
require "ostruct"
require_relative "narou"

#
# Narou.rbのシステムが記録するデータ単位
#
# .narou ディレクトリにYAMLファイルとして保存される
# scope に :global を指定するとユーザーディレクトリ/.narousetting に保存される
#
module Inventory
  def self.load(name = "local_setting", scope = :local)
    @@cache ||= {}
    return @@cache[name] if @@cache[name]
    {}.tap { |h|
      h.extend(Inventory)
      h.init(name, scope)
      @@cache[name] = h
    }
  end

  def self.clear
    @@cache = {}
  end

  def init(name, scope)
    dir = case scope
          when :local
            Narou.local_setting_dir
          when :global
            Narou.global_setting_dir
          else
            raise "Unknown scope"
          end
    return nil unless dir
    @mutex = Mutex.new
    @inventory_file_path = File.join(dir, name + ".yaml")
    return unless File.exist?(@inventory_file_path)
    self.merge!(Helper::CacheLoader.memo(@inventory_file_path) { |yaml|
      begin
        YAML.load(yaml)
      rescue Psych::SyntaxError
        unless restore(@inventory_file_path)
          error "#{@inventory_file_path} が壊れてるっぽい"
          raise
        end
        YAML.load_file(@inventory_file_path)
      end
    })
  end

  def save
    unless @inventory_file_path
      raise "not initialized setting dir yet"
    end
    @mutex.synchronize do
      File.write(@inventory_file_path, YAML.dump(self))
    end
  end

  def restore(path)
    backup_path = "#{path}.backup"
    return nil unless File.exist?(backup_path)
    FileUtils.copy(backup_path, path)
    true
  end

  def group(group_name)
    result = {}
    each do |name, value|
      next unless name =~ /^#{group_name}\.(.+)$/
      child_name = $1
      result[child_name] = value
      lodashed_name = child_name.tr("-", "_")
      result[lodashed_name] = value if child_name != lodashed_name
    end
    OpenStruct.new(result)
  end
end

