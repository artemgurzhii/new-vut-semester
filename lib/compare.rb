#!/usr/bin/env ruby

require 'fileutils'

def compare_output
	begin
		x = FileUtils.compare_file('index.html', 'current.html')
		puts x
	rescue => err
    puts "Exception: #{err}"
    err
	end
end
