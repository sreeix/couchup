class String
  def blank?
    nil || strip.empty?
  end
  
  def constantize
    Object.const_get(self)
  end
  
  def camelize
    gsub(/\/(.?)/) { "::#{$1.upcase}" }.gsub(/(?:^|_)(.)/) { $1.upcase }
  end
  # cargo culted from rails inflector.
  def underscore
    word = dup
    word.gsub!(/::/, '/')
    word.gsub!(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
    word.gsub!(/([a-z\d])([A-Z])/,'\1_\2')
    word.tr!("-", "_")
    word.downcase!
    word
  end
  
end