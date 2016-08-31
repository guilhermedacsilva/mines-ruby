GameMines.load('test/test_helper')

module GameMines
  # Used for tests
  class Mock < Minitest::Mock
    attr_accessor :test_value, :params

    def initialize
      super
      @test_value = false
      @params = false
    end

    def test_params(*args)
      @params = args
    end

    def test_value_true
      @test_value = true
    end

    def test_value_false
      @test_value = false
    end

    def nil?
      false
    end
  end
end
