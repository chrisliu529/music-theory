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
        cases = {
            'C' => ['C', 'D', 'E', 'F', 'G', 'A', 'B'],
            'a' => ["A", "B", "C", "D", "E", "F", "G"],
            'G' => ["G", "A", "B", "C", "D", "E", "F#"],
            'g' => ["G", "A", "Bb", "C", "D", "Eb", "F"],
            'D' => ["D", "E", "F#", "G", "A", "B", "C#"],
            'B#' => ["B#", "Cx", "Dx", "E#", "Fx", "Gx", "Ax"]
        }
        cases.each do |k, v|
            t = Tonic.new(k)
            assert_equal(v,  t.scale)
        end
    end
end
