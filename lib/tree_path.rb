class TreePath
  attr_reader :levels, :depth


  def initialize(path)
    @levels = split_path(path)
    @depth = @levels.size
  end

  def path
    connect_levels(@levels)
  end

  def parent
    @levels.pop
    go(@levels)
  end

  def select(path)
    go(@levels.concat(split_path(path)))
  end

  alias_method :to_s, :path

  private
  def go(levels)
    self.class.new(connect_levels(levels))
  end

  def split_path(path)
    path.to_s.split('.')
  end

  def connect_levels(levels)
    levels.join('.')
  end
end