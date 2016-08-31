# Loads the files
module GameMines
  def self.load(project_path)
    require File.expand_path("../../#{project_path}", __dir__)
  end
end
