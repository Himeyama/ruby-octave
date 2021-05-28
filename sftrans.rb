require "matrix"

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

    if w.class == Array && w.size == 2
        return false
        fl = w[0]
        fh = w[1]
        if stop
            $stdin.puts "未実装"
            if sz.empty?
                # sg = sg * 
            elsif sp.empty?
                # sg = 
            end
        end
    else
        fc = w
        if stop
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
            sp = sp.map{|e| fc * e / c}
            sz = sz.map{|e| fc * e / c}
        end
    end
    [sz, sp, sg]
end

