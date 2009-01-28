require 'osx/cocoa'
OSX.require_framework 'Sparkle'

require 'HeadsUpApplication'
require 'HeadsUpPreferences'

class HeadsUpPreferencePane < OSX::NSPreferencePane
  attr_accessor :application, :preferences, :updater

  def initWithBundle(bundle)
    super_initWithBundle(bundle)
    self.application = HeadsUpApplication.alloc.initWithBundle(bundle)
    self.preferences = HeadsUpPreferences.alloc.initWithBundleIdentifier('org.matthewtodd.HeadsUp')
    self.updater     = OSX::SUUpdater.updaterForBundle(bundle)
    self
  end

  def willSelect
    application.refresh
    preferences.refresh
    updater.resetUpdateCycle
  end
end
