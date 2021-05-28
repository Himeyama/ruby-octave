def bilinear(sz, sp, sg, *t)
    if t.empty?
        t = sg
        sz, sp, sg = tf2zp(sz, sp) #未実装
    else
        t = t[0]
    end

    p = sp.size
    z = sz.size
    
    if z > p || p == 0
        $stderr.puts "エラー"
        exit false
    end

    p sz.map{|e| (2 - e * t) / t}
    # p (2 - sz * t)
    # zg = sg * 

end