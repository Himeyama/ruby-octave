require "matrix"

class Vector
    def prod
        pi = 1
        self.each{|e| pi *= e}
        pi
    end
end

def sftrans(sz, sp, sg, w, stop)
    # sz 配列
    # sp ベクトル
    # sg 値
    # w 値 or 配列?
    # stop 真偽値

    c = 1
    p = sp.size
    z = sz.size

    if z > p || p == 0
        $stderr.puts "エラー"
        return false
    end

    if w.size == 2
        # return false
        fl = w[0]
        fh = w[1]
        if stop
## ----------------  -------------------------  ------------------------
## Band Stop         zero: b ± sqrt(b^2-FhFl)   pole: b ± sqrt(b^2-FhFl)
##        S(Fh-Fl)   pole: ±sqrt(-FhFl)         zero: ±sqrt(-FhFl)
## S -> C --------   gain: -x                   gain: -1/x
##        S^2+FhFl   b=C/x (Fh-Fl)/2            b=C/x (Fh-Fl)/2
## ----------------  -------------------------  ------------------------
            if sz.empty? # ココ
                sg = sg * (1.0 / (-sp.prod)).real
            elsif sp.empty?
                sg = sg * -sz.prod.real
            else
                sg = sg * (-sz.prod / (-sp.prod)).real
            end
            # 続き...
        else
## ----------------  -------------------------  ------------------------
## Band Pass         zero: b ± sqrt(b^2-FhFl)   pole: b ± sqrt(b^2-FhFl)
##        S^2+FhFl   pole: 0                    zero: 0
## S -> C --------   gain: C/(Fh-Fl)            gain: (Fh-Fl)/C
##        S(Fh-Fl)   b=x/C (Fh-Fl)/2            b=x/C (Fh-Fl)/2
## ----------------  -------------------------  ------------------------
            sg = sg * (c / (fh - fl)) ** (z - p)
            b = sp * ((fh - fl) / (2 * c))
            tmp = b.map{|e| CMath::sqrt(e**2 - fh * fl)}
            sp = Vector[*(b + tmp), *(b - tmp)]
            if sz.empty?
                sz = Vector.zero p
            else
                # 未
            end
        end
    else
        fc = w
        if stop
## ----------------  -------------------------  ------------------------
## High Pass         zero: Fc C/x               pole: Fc C/x
## S -> C Fc/S       pole: 0                    zero: 0
##                   gain: -x                   gain: -1/x
## ----------------  -------------------------  ------------------------
            $stdin.puts "未実装"
            if sz.empty?
                sg = nil
            elsif sp.empty?
                sg = nil
            else
                sg = nil
            end
            sp = sp.map{|e| c * fc / e}
            if sz.empty?
                sz = Vector.zero(p)
            else
                sz = sz.map{|e| c * fc / e}
                if p > z
                    sz = Vector[*sz, *Vector.zero(p - z)]
                end
            end
        else
            # p sg, c, fc
            if fc.class == Vector
                sg = fc.map{|e| sg * (c / e) ** (z - p)}
            else
                sg = sg * (c / fc) ** (z - p)
            end
            # 未
        end
    end
    [sz, sp, sg]
end

