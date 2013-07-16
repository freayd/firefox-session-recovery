#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'
require 'active_support/inflector'
require 'json'

# Read sessionstore.bak
filepath = File.join(File.dirname(__FILE__), 'sessionstore.bak')
puts "Reading #{File.expand_path(filepath)} ..."
sessionstore = JSON.parse(IO.read(filepath))
sessionstore['windows'] = [] unless sessionstore.has_key?('windows')
sessionstore['_closedWindows'] = [] unless sessionstore.has_key?('_closedWindows')
opened_windows_count = sessionstore['windows'].length
closed_windows_count = sessionstore['_closedWindows'].length
windows_count = opened_windows_count + closed_windows_count

# Display file content
puts "#{windows_count} window".pluralize(windows_count) + ' found from backup' + (windows_count ? ':' : '')
[ sessionstore['windows'], sessionstore['_closedWindows'] ].each_with_index do |windows, i|
    closed = i == 1
    windows.each do |window|
        puts '  + ' + (closed ? 'closed ' : '') + 'window:'
        puts '    - popup: yes' if window['isPopup']
        puts "    - title: \"#{window['title']}\""

        next unless window['tabs']
        tabs_count = window['tabs'].length
        line = "    - tabs: #{tabs_count}"
        if tabs_count
            line << ' (' << window['tabs'][0]['entries'][0]['url']
            if tabs_count > 1
                line << ' ... ' << window['tabs'].last['entries'].last['url']
            end
            line << ')'
        end
        puts line
    end
end

# Recover closed windows (move them to opened windows)
if sessionstore['_closedWindows'].length
    puts "Recovering #{sessionstore['_closedWindows'].length} closed " + 'windows'.pluralize(sessionstore['_closedWindows'].length)
    sessionstore['windows'].concat(sessionstore['_closedWindows'])
    sessionstore['_closedWindows'] = []
else
    puts 'ERROR: No closed windows found!'
    exit
end

# Write sessionstore.js
filepath = File.join(File.dirname(__FILE__), 'sessionstore.js')
puts "Writing #{File.expand_path(filepath)} ..."
File.open(filepath, 'w') {|f| f.write(sessionstore.to_json) }
