def d(a, b)
    v = (a-b).abs
    v = 12 - v if v > 6
    v
end

def vector(keys)
    v = Array.new(6, 0)
    len = keys.length
    for i in 0..len-2 do
        for j in i+1..len-1 do
            v[d(keys[i], keys[j])-1] += 1
        end
    end
    v
end

s = ARGF.read
keys = s.split(' ').map {|n| n.to_i}
p keys
p vector(keys)
