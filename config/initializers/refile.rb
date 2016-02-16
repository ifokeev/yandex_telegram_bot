Refile.configure do |config|
  config.cache = Refile::Memory::Backend.new
  config.store = Refile::Backend::FileSystem.new("tmp")
  config.secret_key = 'monolama12'
end
