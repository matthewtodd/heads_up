require 'rake/clean'
require 'erb'

rule '.o' => ['.m'] do |task|
  sh "/usr/bin/gcc-4.0 -c #{task.source} -o #{task.name}"
end; CLEAN.include('**/*.o')

def bundle(name, options)
  link_flags     = options[:link_flags] || []
  frameworks     = options[:link_frameworks] || []
  prefix         = options[:prefix] || ''
  source         = options[:source] || raise('source is required')
  contents_dir   = File.expand_path("release/#{prefix}/#{name}/Contents")
  frameworks_dir = "#{contents_dir}/Frameworks"
  mac_os_dir     = "#{contents_dir}/MacOS"
  resources_dir  = "#{contents_dir}/Resources"
  executable     = "#{mac_os_dir}/#{name.pathmap('%n')}" # pathmap is from Rake; %n is basename without extension
  object_file    = "#{source}/ext/main.o"

  task name => object_file do
    mkdir_p contents_dir
    File.open("#{contents_dir}/Info.plist", 'w') { |file| file.write(ERB.new(File.read("#{source}/Info.plist")).result) }
    rm_rf frameworks_dir # HACK: FileUtils.cp_r blows up instead of overwriting symlinks, even with :remove_destination => true
    mkdir_p frameworks_dir
    cp_r Dir.glob("#{source}/vendor/frameworks/*"), frameworks_dir
    mkdir_p mac_os_dir
    sh "/usr/bin/gcc-4.0 -o %s %s %s %s %s" % [executable, "-F#{frameworks_dir}", frameworks.map { |name| "-framework #{name}" }.join(' '), link_flags.join(' '), object_file]
    mkdir_p resources_dir
    cp_r Dir.glob("#{source}/lib/*"), resources_dir
    cp_r Dir.glob("#{source}/resources/*"), resources_dir
  end
end; CLEAN.include('release')

class HeadsUp
  SHORT_VERSION = '0.1.0'
  VERSION       = "#{SHORT_VERSION}.#{Time.now.utc.strftime('%Y%m%d%H%M%S')}.#{`git show-ref --hash HEAD`.chomp}"

  def self.create_release
    new.create_release
  end

  def self.disk_image
    "HeadsUp-#{SHORT_VERSION}.dmg"
  end

  def self.volume_name
    'HeadsUp'
  end

  def create_release
    FileUtils.cp disk_image, 'website/releases'

    File.open(release_announcement, 'w') do |file|
      file.puts '---'
      file.puts "title: HeadsUp #{SHORT_VERSION}"
      file.puts "dmg: /releases/#{disk_image}"
      file.puts "version: #{VERSION}"
      file.puts "short_version: #{SHORT_VERSION}"
      file.puts "length: #{disk_image_size}"
      file.puts "signature: #{disk_image_signature}"
      file.puts "minimum_system_version: #{minimum_system_version}"
      file.puts '---'
      file.puts 'h2. Changelog'
      file.puts
      commits.each { |commit| file.puts "* #{commit}" } # TODO include dates? include authors? include links to commits on github?
    end
  end

  private

  def commits
    last_tag = `git tag | tail -1`.chomp
    range = (last_tag.empty?) ? '' : "#{last_tag}.."
    `git log --pretty=format:%s #{range}`.split(/\n/)
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

  def minimum_system_version
    '10.4.11'
  end

  def private_key
    "#{ENV['HOME']}/.signing_keys/dsa_priv.pem"
  end

  def release_announcement
    "website/_posts/releases/#{Date.today.strftime('%Y-%m-%d')}-version-#{SHORT_VERSION}"
  end
end

task :default => :open

desc 'Build HeadsUp.prefPane'
task :build => ['HeadsUp.prefPane', 'HeadsUp.app']

desc 'Edit the HeadsUp Preference Pane NIB.'
task :edit do
  sh 'open preference_pane/resources/English.lproj/HeadsUpPreferencePane.nib'
end

desc 'Open HeadsUp.prefPane.'
task :open => :build do
  sh 'open release/HeadsUp.prefPane'
end

desc 'Package HeadsUp.dmg.'
task :package => [:clean, :build] do
  sh "hdiutil create -volname #{HeadsUp.volume_name} -srcfolder release #{HeadsUp.disk_image}"
end; CLEAN.include('*.dmg')

bundle 'HeadsUp.prefPane', :source => 'preference_pane', :link_frameworks => ['Cocoa', 'RubyCocoa', 'AppKit', 'PreferencePanes'], :link_flags => ['-bundle']
bundle 'HeadsUp.app',      :source => 'application',     :link_frameworks => ['Cocoa', 'RubyCocoa'], :prefix => 'HeadsUp.prefPane/Contents/Resources'

namespace :website do
  desc 'Build the website.'
  task(:build)   { sh 'jekyll website public' }
  desc 'Delete generated website files.'
  task(:clean)   { sh 'rm -rf public' }
  desc 'Serve the website, noticing file changes.'
  task(:reserve) { sh 'jekyll website public --auto --server 3000' }
  desc 'Serve the website.'
  task(:serve)   { sh 'jekyll website public --server 3000' }
end; CLEAN.include('public')

desc 'Release HeadsUp.dmg.'
task :release => [:package] do
  HeadsUp.create_release
end
