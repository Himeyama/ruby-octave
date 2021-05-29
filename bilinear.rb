require "./postpad"

class Vector
    def prod
        pi = 1
        self.each{|e| pi *= e}
        pi
    end
end

def bilinear(sz, sp, sg, *t)
    # p sz, sp, sg, t
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

## ----------------  -------------------------  ------------------------
## Bilinear          zero: (2+xT)/(2-xT)        pole: (2+xT)/(2-xT)
##      2 z-1        pole: -1                   zero: -1
## S -> - ---        gain: (2-xT)/T             gain: (2-xT)/T
##      T z+1
## ----------------  -------------------------  ------------------------

    # p sg, sz, sp
    # p ((sz.map{|e| 2-e*t}) / t).prod
    zg = (sg * prod((-sz*t).plus(2)/t) / prod((-sp*t).plus(2)/t)).real
    zp = sp.map{|e| (2 + e * t) / (2 - e * t)}
    if sz.size == 0
        zz = Matrix.columns(Array.new(zp.size){Array.new(zp.size){-1}})
    else
        zz = sz.map{|e| (2 + e * t) / (2 - e * t)}
        zz = postpad(zz, p, -1)
    end

    # p zz

    # if nargout==2
    #     [Zz, Zp] = zp2tf(Zz, Zp, Zg)
    # end
    [zz, zp, zg]
end