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
        if ki >= keys.length
            ki -= keys.length
        end
        name = next_keyname(k[0])
        keys[ki].each do |n|
            if n[0] == name
                return n
            end
        end
        raise "next_key(#{k}, #{i}) not found"
    end

    def next_keyname(name)
        names = Array('A'..'G')
        i = names.index(name) + 1
        if i > 6
            names[0]
        else
            names[i]
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
