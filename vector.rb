def d(a, b)
    v = (a-b).abs
    if v > 6
        v = 12 - v
    end
    return v
end

def vector(keys)
    v = Array.new(6, 0)
    len = keys.length
    for i in 0..len-2 do
        for j in i+1..len-1 do
            v[d(keys[i], keys[j])-1] += 1
        end
    end
    return v
end

s = ARGF.read
keys = s.split(' ').map {|n| n.to_i}
p keys
p vector(keys)
