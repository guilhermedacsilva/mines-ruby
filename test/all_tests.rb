# For documentation: http://docs.seattlerb.org/minitest/
require File.expand_path('../lib/util/loader', __dir__)
Dir['**/*_test.rb'].each { |test_case| GameMines.load(test_case) }
