require 'bundler'
require 'osx/cocoa'
require 'tempfile'

Bundler.require

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

class FinderPreferences
  include Appscript

  KEYS = %w(
    desktop_shows_hard_disks
    desktop_shows_external_hard_disks
    desktop_shows_removable_media
    desktop_shows_connected_servers
  )

  class << self
    def hide_desktop_items(&block)
      new.hide_desktop_items(&block)
    end
  end

  def initialize
    finder = app('Finder').Finder_preferences
    @preferences = KEYS.collect { |key| finder.send(key) }.
                     inject({}) { |hash, key| hash[key] = key.get; hash }
  end

  def hide_desktop_items(&block)
    @preferences.each { |preference, initial_value| preference.set(false) }
    block.call
  ensure
    @preferences.each { |preference, initial_value| preference.set(initial_value) }
  end
end

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

class Project
  class << self
    def artifact
      "build/Release/#{name}.app"
    end

    def demo(*options, &block)
      pid = fork { exec "#{artifact}/Contents/MacOS/#{name}", *options }
      sleep 2
      Appscript.app(name).activate
      sleep 2
      block.call
    ensure
      Process.kill('KILL', pid)
    end

    def disk_image_path
      "#{name}-#{marketing_version}.dmg"
    end

    # TODO determine download url from somewhere?
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

    # TODO determine this unix_name automatically?
    def unix_name
      'heads_up'
    end

    def version
      `agvtool vers -terse`.strip
    end
  end
end

class Screen
  class << self
    def resize(width, height, &block)
      new.resize(width, height, &block)
    end
  end

  def initialize(screen = OSX::CGMainDisplayID())
    @screen = screen
    @mode   = OSX::CGDisplayCopyDisplayMode(@screen)
  end

  def resize(width, height, &block)
    configure(best_mode(width, height))
    block.call
  ensure
    configure(@mode)
  end

  private

  def best_mode(width, height)
    # TODO Try to figure out color depth from CGDisplayModeCopyPixelEncoding?
    OSX::CGDisplayCopyAllDisplayModes(@screen, nil).detect do |mode|
      OSX::CGDisplayModeGetWidth(mode) == width &&
      OSX::CGDisplayModeGetHeight(mode) == height &&
      OSX::CGDisplayModeIsUsableForDesktopGUI(mode)
    end
  end

  def configure(mode)
    result, config = OSX::CGBeginDisplayConfiguration()
    if result == OSX::KCGErrorSuccess
      OSX::CGConfigureDisplayWithDisplayMode(config, @screen, mode, nil)
      OSX::CGCompleteDisplayConfiguration(config, OSX::KCGConfigureForSession)
    else
      raise "I have no clue what just happened: #{result}"
    end
  end
end

class SystemEvents
  include Appscript

  class << self
    def hide_others(name, &block)
      new(name).hide_others(&block)
    end
  end

  def initialize(name)
    @target = app(name)
    @others = app('System Events').processes[its.name.ne(name).and(its.visible.eq(true))].get
  end

  def hide_others(&block)
    @target.activate
    @others.each { |p| p.visible.set(false) }
    block.call
  ensure
    @others.each { |p| p.visible.set(true) }
  end
end

class Website
  class << self
    def configuration_path
      'website/_config.yml'
    end

    def configure(options)
      File.open(configuration_path, 'w') do |file|
        file.write(configuration.merge(options).to_yaml)
      end
    end

    def release_announcement_path
      "website/_posts/#{Date.today.strftime('%Y-%m-%d')}-version-#{Project.marketing_version}.textile"
    end

    def screenshot_path
      'website/images/screenshot.jpg'
    end

    def small_screenshot_path
      'website/images/screenshot-small.jpg'
    end

    private

    def configuration
      YAML.load_file(configuration_path)
    end
  end
end

file Project.artifact do
  sh 'xcodebuild'
end

file Project.disk_image_path => Project.artifact do |task|
  Dir.mktmpdir do |path|
    FileUtils.rm_r task.name, :force => true
    FileUtils.cp_r task.prerequisites, path
    FileUtils.ln_s '/Applications', "#{path}/Applications"
    sh "hdiutil create -volname #{Project.name} -srcfolder #{path} #{task.name}"
  end
end

file Website.configuration_path do
  Website.configure(
    'latest_disk_image_url'  => Project.disk_image_url,
    'latest_disk_image_name' => Project.disk_image_path
  )
end

file Website.release_announcement_path => Project.disk_image_path do |task|
  File.open(task.name, 'w') do |file|
    file.puts '---'
    file.puts "title: #{Project.name} #{Project.marketing_version}"
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

file Website.screenshot_path => Project.artifact do |task|
  SystemEvents.hide_others('Finder') do
    Screen.resize(1024, 768) do
      FinderPreferences.hide_desktop_items do
        Project.demo('-bottom_left', 'echo "Welcome to HeadsUp!"', '-bottom_right', 'cal') do
          sh "screencapture -m -tjpg #{task.name}"
        end
      end
    end
  end
end

file Website.small_screenshot_path => Website.screenshot_path do |task|
  sh "convert -resize 300x #{task.prerequisites} #{task.name}"
end

desc 'Remove generated artifacts.'
task :clean do
  sh 'xcodebuild clean'
  FileUtils.rm Dir['*.dmg']
end

desc "Build #{Project.disk_image_path}"
task :default => Project.disk_image_path

unless Git.dirty? || Git.has_tag?(Project.marketing_version)
  desc "Prepare to release #{Project.name} #{Project.marketing_version}"
  task :prepare_release => [
    :clean,
    Project.disk_image_path,
    Website.configuration_path,
    Website.release_announcement_path,
    Website.screenshot_path,
    Website.small_screenshot_path,
    :website
  ] do
    puts "Now, tweak the release notes, upload the disk image, commit the website, commit the project, tag #{Project.marketing_version} and push."
  end

  desc "Upload the disk image to GitHub."
  task :upload => Project.disk_image_path do
    Net::GitHub::Upload.new(
      :login => `git config github.user`.chomp,
      :token => `git config github.token`.chomp
    ).upload(
      :repos => Project.unix_name,
      :file => Project.disk_image_path
    )
  end
end

desc 'See how the GitHub Pages will look.'
task :website do
  pid = fork do
    Dir.mktmpdir do |path|
      exec 'jekyll', 'website', path, '--auto', '--base-url', "/#{Project.unix_name}", '--server', '3000'
    end
  end

  begin
    sleep 2
    sh 'open', '-Wn', "http://localhost:3000/#{Project.unix_name}/"
  ensure
    Process.kill('KILL', pid)
  end
end
