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


    def keys
        [
            ['C', 'B#'],
            ['C#', 'Db'],
            ['D'],
            ['D#', 'Eb'],
            ['E'],
            ['F', 'E#'],
            ['F#', 'Gb'],
            ['G'],
            ['G#', 'Ab'],
            ['A'],
            ['A#', 'Bb'],
            ['B'],
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
        if ki >= keys.length
            ki = 0
        end
        k0 = keys[ki][0]
        if k0[0] == k[0]
            keys[ki][1]
        else
            k0
        end
    end

    def key_index(key)
        keys.each_with_index do |s, i|
            s.each do |k|
                if k == key
                    return i
                end
            end
        end
    end

    def note(n, v)
        v1 = ''
        if v == 'sharp'
            v1 = '#'
        elsif v == 'flat'
            v1 = 'b'
        end
        n + v1
    end

    def scale
        key = note(@first, @variant)
        s = [key]
        intervals.each do |i|
            k2 = next_key(key, i)
            s << k2
            key = k2
        end
        return s
    end
end
