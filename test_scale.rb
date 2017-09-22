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

    def insert_key(result, key)
        s = Tonic.new(key).scale
        if s.any?{|k| k.length == 3 or k.include? 'x'}
            false
        else
            result[key] = s
            true
        end
    end

    def simple_scales(key)
        result = {}
        insert_key(result, key)
        queue = [key]
        visited = {}
        while queue.length > 0 do
            key = queue.shift
            visited[key] = true
            k1 = move_key(key, 4)
            k2 = move_key(key, 3)
            if insert_key(result, k1)
                queue.push(k1) unless visited[k1]
            end
            if insert_key(result, k2)
                queue.push(k2) unless visited[k2]
            end
        end
        result
    end

    def test_5degree
        ss = simple_scales('C')
        puts "\n#{ss.length} simple major scales:"
        ss.each do |k, v|
            puts
            p k, v
        end

        ss = simple_scales('a')
        puts "\n#{ss.length} simple minor scales:"
        ss.each do |k, v|
            puts
            p k, v
        end
    end
end
