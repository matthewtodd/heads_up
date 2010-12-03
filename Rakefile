require 'rake/clean'
require 'erb'
require 'tempfile'

class HeadsUp
  SHORT_VERSION = `agvtool mvers -terse1`.strip
  VERSION       = "#{SHORT_VERSION}.#{Time.now.utc.strftime('%Y%m%d%H%M%S')}.#{`git show-ref --hash=8 HEAD`.chomp}"

  def self.check_release
    new.check_release
  end

  def self.create_release
    new.create_release
  end

  def self.disk_image
    "HeadsUp-#{SHORT_VERSION}.dmg"
  end

  def self.volume_name
    'HeadsUp'
  end

  def check_release
    die("Current directory has uncommitted changes.") if unclean?
    die("Version #{SHORT_VERSION} has already been released.\nUpdate CFBundleShortVersionString in HeadsUp-Info.plist.") if tags.include?(SHORT_VERSION)
  end

  def create_release
    self.check_release

    FileUtils.mkdir_p('website/releases')
    FileUtils.cp(disk_image, 'website/releases')
    FileUtils.mkdir_p(File.dirname(release_announcement))

    File.open(release_announcement, 'w') do |file|
      file.puts '---'
      file.puts "title: HeadsUp #{SHORT_VERSION}"
      file.puts "layout: default"
      file.puts "dmg: #{disk_image_url}"
      file.puts "dmg_name: #{disk_image}"
      file.puts "version: #{VERSION}"
      file.puts "short_version: #{SHORT_VERSION}"
      file.puts "length: #{disk_image_size}"
      file.puts "signature: #{disk_image_signature}"
      file.puts "minimum_system_version: #{minimum_system_version}"
      file.puts 'category: releases'
      file.puts '---'
      file.puts 'h3. Changelog'
      file.puts
      commits.each { |commit| file.puts "* #{commit}" } # TODO include dates? include authors? include links to commits on github?
    end

    FileUtils.mkdir_p('website/_includes')
    File.open(download_latest, 'w') do |file|
      file.puts %Q{<a href="/heads_up#{disk_image_url}" class="download"><img src="/heads_up/images/dmg.png" class="icon" />#{disk_image}</a>}
    end

    FileUtils.mkdir_p('website/images')
    Screenshot.take('website/images')

    puts "Now, tweak the release notes, commit the website, commit the project, tag #{SHORT_VERSION}, and push."
  end

  private

  def commits
    range = (tags.last.to_s.empty?) ? '' : "#{tags.last}.."
    `git log --pretty=format:%s #{range}`.split(/\n/)
  end

  def die(message)
    puts message
    exit 1
  end

  def disk_image
    self.class.disk_image
  end

  def disk_image_signature
    `openssl dgst -sha1 -binary < "#{disk_image}" | openssl dgst -dss1 -sign "#{private_key}" | openssl enc -base64`.chomp
  end

  def disk_image_size
    File.size(disk_image)
  end

  def disk_image_url
    "/releases/#{disk_image}"
  end

  def download_latest
    "website/_includes/download.html"
  end

  def minimum_system_version
    '10.4.11'
  end

  def private_key
    "#{ENV['HOME']}/.signing_keys/dsa_priv.pem"
  end

  def release_announcement
    "website/_posts/#{Date.today.strftime('%Y-%m-%d')}-version-#{SHORT_VERSION}.textile"
  end

  def tags
    @tags ||= `git tag`.split(/\n/)
  end

  def unclean?
    `git status`.grep(/working directory clean/).empty?
  end

  class Screenshot
    def self.take(path)
      new.take(path)
    end

    def take(path)
      original_frame = current_frame

      script('tell application "System Preferences" to quit')
      script('tell application "Finder" to open home')
      script('tell application "Finder" to set visible of every process whose name is not "Finder" to false')
      resize(1024, 768)
      script('tell application "System Preferences" to activate')
      script('tell application "System Preferences" to set current pane to pane "org.matthewtodd.HeadsUp.preferences"')
      script('tell application "Finder" to set visible of every process whose name is not "System Preferences" to false')

      `screencapture -m -tjpg #{path}/screenshot.jpg`
      `convert -resize 300x #{path}/screenshot.jpg #{path}/screenshot-small.jpg`

      resize(*original_frame)
      script('tell application "System Preferences" to quit')
    end

    private

    def current_frame
      require 'osx/cocoa'
      frame = OSX::NSScreen.mainScreen.frame
      [frame.width.to_i, frame.height.to_i]
    end

    def resize(width, height)
      `utilities/cscreen.exe -x #{width} -y #{height}`
    end

    def script(string)
      `osascript -e '#{string}'`
    end
  end
end

task :default => :open

desc 'Build HeadsUp.app'
task :build do
  sh 'xcodebuild -configuration Release build'
end

desc 'Edit the HeadsUp XIB.'
task :edit do
  sh 'open English.lproj/MainMenu.xib'
end

desc 'Open HeadsUp.prefPane.'
task :open => :build do
  sh 'open build/Release/HeadsUp.app'
end

desc 'Package HeadsUp.dmg.'
task :package => [:clean, :build] do
  Dir.mktmpdir do |path|
    FileUtils.cp_r 'build/Release/HeadsUp.app', path
    sh "hdiutil create -volname #{HeadsUp.volume_name} -srcfolder #{path} #{HeadsUp.disk_image}"
  end
end; CLEAN.include('*.dmg')

desc 'Release HeadsUp.dmg.'
task :release => [:check_release, :package] do
  HeadsUp.create_release
end

task :check_release do
  HeadsUp.check_release
end

namespace :website do
  desc 'Build the website.'
  task :build do
    sh 'jekyll website public/heads_up'
  end

  desc 'Delete generated website files.'
  task :clean do
    sh 'rm -rf public'
  end

  desc 'Serve the website.'
  task :serve => :build do
    require 'webrick'
    server = WEBrick::HTTPServer.new(:Port => 3000, :DocumentRoot => 'public')
    thread = Thread.new { server.start }
    trap('INT') { server.shutdown }
    thread.join
  end
end; CLEAN.include('public')
