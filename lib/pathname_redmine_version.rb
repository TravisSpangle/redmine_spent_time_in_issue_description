# Shortcut and readable method name
class Pathname
  def redmine_version
    basename.to_s[0..4]
  end
end
