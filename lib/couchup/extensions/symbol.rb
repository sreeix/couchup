class Symbol
  def constantize
    Object.const_get(to_s)
  end
  
  # cargo culted from rails inflector.
  def underscore
    word = to_s.dup
    word.gsub!(/::/, '/')
    word.gsub!(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
    word.gsub!(/([a-z\d])([A-Z])/,'\1_\2')
    word.tr!("-", "_")
    word.downcase!
    word
  end
end