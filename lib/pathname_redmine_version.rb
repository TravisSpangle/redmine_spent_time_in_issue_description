class Pathname
  def redmine_version
    self.basename.to_s[0..4]
  end
end
