require 'osx/cocoa'

class HeadsUpTextView < OSX::NSTextView
  def initWithFrame(frame)
    super_initWithFrame(frame)

    setBackgroundColor(OSX::NSColor.clearColor)
    setFont(OSX::NSFont.fontWithName_size('Monaco', 12.0))
    setTextColor(OSX::NSColor.whiteColor.colorWithAlphaComponent(0.5))

    setString('Hello, World!')
    self
  end
end