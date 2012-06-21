require 'fileutils'

task :default => [:build]

task :build do
  Dir.chdir("client") do
    sh "bundle exec ocra fun.rb wget.exe madplay.exe"
    mv("fun.exe",  "../bin")
  end
end
