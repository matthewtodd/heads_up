require 'osx/cocoa'

class HeadsUpPreferencePane < OSX::NSPreferencePane
  ib_outlet :values

  def initWithBundle(bundle)
    super_initWithBundle(bundle)
    defaults = OSX::NSUserDefaults.alloc.init
    defaults.addSuiteNamed('org.matthewtodd.HeadsUpApp')
    defaults.removeSuiteNamed('com.apple.systempreferences')
    @controller = OSX::NSUserDefaultsController.alloc.initWithDefaults_initialValues(defaults, :bottom_left => '', :bottom_right => '')
    self
  end

  def values
    @controller.values
  end
end
