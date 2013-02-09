# -*- coding: UTF-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require_relative "narou"
require_relative "command"
require_relative "helper"

module CommandLine
  def self.run(argv)
    if Helper.os_windows?
      argv.map! do |arg|
        arg.encode(Encoding::UTF_8)
      end
    end
    argv.unshift("help") if argv.empty?
    arg = argv.shift.downcase
    arg = Command::Shortcuts[arg] || arg
    arg = "help" if arg == "-h" || arg == "--help"
    arg = "version" if arg == "-v" || arg == "--version"
    if Narou.already_init?
      if arg == "init"
        puts "すでに初期化済みです"
        return
      end
    else
      if arg != "init"
        arg = "help"
      end
    end
    unless Command.get_list.include?(arg)
      puts "不明なコマンドです"
      puts
      arg = "help"
    end
    Command.get_list[arg].execute(argv)
  end
end