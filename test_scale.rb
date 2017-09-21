require "test/unit"
require_relative "tonic"

class TestScale < Test::Unit::TestCase
    def test_tonic
        t = Tonic.new('')
        assert_equal(true,  t.error)

        t = Tonic.new('C')
        assert_equal(nil,  t.error)
        assert_equal(nil,  t.variant)
        assert_equal(true,  t.major)

        t = Tonic.new('a')
        assert_equal(nil,  t.error)
        assert_equal(nil,  t.variant)
        assert_equal(false,  t.major)

        t = Tonic.new('eb')
        assert_equal(nil,  t.error)
        assert_equal('flat',  t.variant)
        assert_equal(false,  t.major)
    end

    def test_scale
        t = Tonic.new('C')
        assert_equal(['C', 'D', 'E', 'F', 'G', 'A', 'B'],  t.scale)
    end
end
