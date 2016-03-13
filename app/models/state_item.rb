class StateItem < ApplicationRecord
  before_save :set_tree_path

  after_commit :rewrite_cache, on: %i(create update)
  after_commit :expire_cache, on: %i(destroy)

  validates :header, presence: true

  class StateItemNotFound < RuntimeError; end

  class << self
    def destroy(path)
      path = path.to_s
      obj = object(path)
      raise StateItemNotFound, "State Item \"#{path}\" not found" if obj.nil?

      obj.destroy!
      true
    end

    def get_childs(starting_with = nil, depth = nil)
      paths = self

      if starting_with
        tree_path = TreePath.new(starting_with)
        paths = paths.where("path LIKE '#{tree_path.to_s}%'")
        paths = paths.where("depth = #{depth}") if depth
      end

      paths.index_by(&:path)
    end

    def [](path)
      Rails.cache.fetch(ckey(path)) do
        object(path).try(:header)
      end
    end

    def []=(path, value)
      tree_path = TreePath.new(path)

      record = object(tree_path) || self.new(path: path)
      record.header = value
      record.save!

      value
    end

    def object(path)
      where(path: path.to_s).first
    end

    def ckey(path)
      ['StateItem', path].join('/')
    end
  end

  private
  def set_tree_path
    tree_path = TreePath.new(self.path)
    self.path = tree_path.to_s
    self.depth = tree_path.depth
  end

  def rewrite_cache
    Rails.cache.write(self.class.ckey(path), header)
  end

  def expire_cache
    Rails.cache.delete(self.class.ckey(path))
  end
end
