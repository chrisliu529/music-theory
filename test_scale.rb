#!/usr/bin/ruby

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
            'F' => ["F", "G", "A", "Bb", "C", "D", "E"],
            'g' => ["G", "A", "Bb", "C", "D", "Eb", "F"],
            'D' => ["D", "E", "F#", "G", "A", "B", "C#"],
            'B#' => ["B#", "Cx", "Dx", "E#", "Fx", "Gx", "Ax"],
            'db' => ["Db", "Eb", "Fb", "Gb", "Ab", "Bbb", "Cb"]
        }
        cases.each do |k, v|
            t = Tonic.new(k)
            assert_equal(v,  t.scale)
        end
    end

    def move_key(key, n)
        t = Tonic.new(key)
        k1 = t.scale[n]
        if t.major
            k1
        else
            to_minor(k1)
        end
    end

    def to_minor(key)
        key[0].downcase + key[1..key.length]
    end

    def is_simple?(s)
        not s.any?{|k| k.length == 3 or k.include? 'x'}
    end

    def simple_scales(key)
        result = {key => Tonic.new(key).scale}
        queue = [key]
        visited = {}
        while queue.length > 0 do
            key = queue.shift
            visited[key] = true
            (3..4).each do |i|
                k = move_key(key, i)
                s = Tonic.new(k).scale
                if is_simple?(s)
                    result[k] = s
                    queue.push(k) unless visited[k]
                end
            end
        end
        result
    end

    def test_5degree
        ss = simple_scales('C')
        assert_equal(15, ss.length)
        puts "\n#{ss.length} simple major scales:"
        ss.each do |k, v|
            puts
            p k, v
        end

        ss = simple_scales('a')
        assert_equal(15, ss.length)
        puts "\n#{ss.length} simple minor scales:"
        ss.each do |k, v|
            puts
            p k, v
        end
    end
end
