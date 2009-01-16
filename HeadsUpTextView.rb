require 'osx/cocoa'

class HeadsUpTextView < OSX::NSTextView
  def initWithFrame(frame)
    super_initWithFrame(frame)

    setBackgroundColor(OSX::NSColor.clearColor)
    setFont(OSX::NSFont.fontWithName_size('Monaco', 12.0))
    setString(`/Users/mtodd/Code/events/bin/events`)
    setTextColor(OSX::NSColor.whiteColor.colorWithAlphaComponent(0.5))

    self
  end

  def setString(string)
    super_setString(bottomJustify(string))
  end

  private

  def bottomJustify(string)
    lines = string.split(/\n/)
    (12 - lines.size).times { lines.unshift('') }
    lines.join("\n")
  end
end