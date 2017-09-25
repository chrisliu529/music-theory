class Tonic
    attr_reader :first, :major, :variant, :error

    def initialize(spec)
        if spec.length == 2
            parse_variant(spec[1])
            if @error
                return
            end
            parse_first(spec[0])
        elsif spec.length == 1
            parse_first(spec[0])
        else
            @error = true            
        end
    end

    def scale
        key = note(@first, @variant)
        intervals.inject([key]) do |acc, i|
            key = next_key(key, i)
            acc << key
        end
    end

private
    def keys
        [
            ['C', 'B#'],
            ['C#', 'Db'],
            ['D', 'Cx'],
            ['D#', 'Eb'],
            ['E', 'Dx', 'Fb'],
            ['F', 'E#'],
            ['F#', 'Gb'],
            ['G', 'Fx'],
            ['G#', 'Ab'],
            ['A', 'Gx', 'Bbb'],
            ['A#', 'Bb'],
            ['B', 'Ax', 'Cb'],
        ]
    end

    def parse_variant(v)
        if v == '#'
            @variant = 'sharp'
        elsif v == 'b'
            @variant = 'flat'
        else
            @error = true
        end
    end

    def parse_first(k)
        if ('A'..'G').include? k
            @first = k
            @major = true
        elsif ('a'..'g').include? k
            @first = k.upcase
            @major = false
        else
            @error = true
        end
    end

    def intervals
        if @major
            [2, 2, 1, 2, 2, 2]
        else
            [2, 1, 2, 2, 1, 2]
        end
    end

    def next_key(k, i)
        ki = key_index(k) + i
        ki -= keys.length if ki >= keys.length
        name = next_keyname(k[0])
        keys[ki].each {|n| return n if n[0] == name}
        raise "next_key(#{k}, #{i}) not found"
    end

    def next_keyname(name)
        names = Array('A'..'G')
        i = names.index(name) + 1
        i = 0 if i > 6
        names[i]
    end

    def key_index(key)
        keys.each_with_index {|s, i| s.each {|k| return i if k == key}}
    end

    def note(n, v)
        v1 =
            if v == 'sharp'
                '#'
            elsif v == 'flat'
                'b'
            else
                ''
            end
        n + v1
    end
end
