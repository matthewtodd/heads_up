require 'bundler'
require 'tempfile'

Bundler.require

class Git
  class << self
    def commits
      `git log --pretty=format:%s #{tags.last}..`.strip.split("\n")
    end

    def dirty?
      `git status`.grep(/working directory clean/).empty?
    end

    def has_tag?(tag)
      tags.include?(tag)
    end

    private

    def tags
      `git tag`.strip.split("\n")
    end
  end
end

class Crypto
  class << self
    def signature(path)
      `openssl dgst -sha1 -binary < "#{path}" | openssl dgst -dss1 -sign "#{private_key}" | openssl enc -base64`.strip
    end

    private

    def private_key
      "#{ENV['HOME']}/.signing_keys/dsa_priv.pem"
    end
  end
end

class Project
  class << self
    def artifact
      "build/Release/#{name}.app"
    end

    def disk_image_path
      "#{name}-#{marketing_version}.dmg"
    end

    def disk_image_url
      "https://github.com/downloads/matthewtodd/heads_up/#{disk_image_path}"
    end

    def marketing_version
      `agvtool mvers -terse1`.strip
    end

    def minimum_system_version
      settings = `grep MACOSX_DEPLOYMENT_TARGET #{name}.xcodeproj/project.pbxproj`
      versions = settings.scan(/[.0-9]+/).sort.uniq
      abort("Multiple versions specified:\n#{settings}") if versions.size > 1
      versions.first
    end

    # TODO read name from XCode config?
    def name
      'HeadsUp'
    end

    def version
      `agvtool vers -terse`.strip
    end
  end
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

file Project.artifact do
  sh 'xcodebuild'
end

file Project.disk_image_path => Project.artifact do |task|
  Dir.mktmpdir do |path|
    FileUtils.rm_r task.name, :force => true
    FileUtils.cp_r task.prerequisites, path
    sh "hdiutil create -volname #{Project.name} -srcfolder #{path} #{task.name}"
  end
end

desc 'Release HeadsUp.dmg.'
task :release => 'release:safeguard' do
  Rake::Task['package'].invoke
  Rake::Task['release:upload'].invoke
  Rake::Task['release:announce'].invoke
  Rake::Task['release:shoot'].invoke
  puts "Now, tweak the release notes, commit the website, commit the project, tag #{Project.marketing_version} and push."
end

namespace :release do
  task :safeguard do
    abort("Current directory has uncommitted changes.") if Git.dirty?
    abort("Version #{Project.marketing_version} has already been released.\nRun `agvtool new-marketing-version VERSION` to set a new version number.") if Git.has_tag?(Project.marketing_version)
  end

  task :upload do
    Net::GitHub::Upload.new(
      :login => `git config github.user`.chomp,
      :token => `git config github.token`.chomp
    ).upload(
      :repos => 'heads_up',
      :file => Project.disk_image_path
    )
  end

  task :publish do
    path = 'website/_includes/download.html'

    FileUtils.mkdir_p(File.dirname(path))

    File.open(path, 'w') do |file|
      file.puts %Q{<a href="#{Project.disk_image_path}" class="download"><img src="/heads_up/images/dmg.png" class="icon" />#{Project.disk_image_path}</a>}
    end
  end

  task :announce do
    path = "website/_posts/#{Date.today.strftime('%Y-%m-%d')}-version-#{Project.marketing_version}.textile"

    FileUtils.mkdir_p(File.dirname(path))

    File.open(path, 'w') do |file|
      file.puts '---'
      file.puts "title: HeadsUp #{Project.marketing_version}"
      file.puts "layout: default"
      file.puts "dmg: #{Project.disk_image_url}"
      file.puts "dmg_name: #{Project.disk_image_path}"
      file.puts "version: #{Project.version}"
      file.puts "short_version: #{Project.marketing_version}"
      file.puts "length: #{File.stat(Project.disk_image_path).size}"
      file.puts "signature: #{Crypto.signature(Project.disk_image_path)}"
      file.puts "minimum_system_version: #{Project.minimum_system_version}"
      file.puts 'category: releases'
      file.puts '---'
      file.puts 'h3. Changelog'
      file.puts
      Git.commits.each { |commit| file.puts "* #{commit}" }
    end
  end

  task :shoot do
    Screenshot.take('website/images')
  end
end

desc 'See how the GitHub Pages will look.'
task :website do
  fork do
    sleep 2
    exec 'open', 'http://localhost:3000/heads_up/'
  end

  Dir.mktmpdir do |path|
    exec 'bundle', 'exec', 'jekyll', 'website', path, '--auto', '--base-url', '/heads_up', '--server', '3000'
  end
end
