require "matrix"
require "cmath"
require "./sftrans"
require "./bilinear"

def butter(n, wc, *varargin)
    a, b, c, d = 1, 2, 3, 4

    stop = false
    digital = true
    if digital
        t = 2.0
        if wc.class == Array
            wc = Vector[*wc]
            wc = 2.0 / t * wc.map{|e| Math::tan(Math::PI * e / t) }
        else    
            wc = 2.0 / t * Math::tan(Math::PI * wc / t)
        end
    end

    c = 1
    pole = c * (1i * Math::PI * ((2 * Vector[*(1..n).to_a]) + Vector[*Array.new(n){|i| n - 1}]) / (2 * n)).map{|e| CMath::exp e}
    if n % 2 == 1
        pole[(n + 1) / 2.0 - 1] = -1
    end
    zero = []
    gain = c ** n

    # 平面周波数変換
    # p zero, pole,gain,wc,stop
    # return
    zero, pole, gain = sftrans(zero, pole, gain, wc, stop)

    # p zero, pole, gain

    # puts "zero = #{zero}"
    # p zero

    # p pole

    if digital
        # puts "zero=#{zero}, pole=#{pole}, gain=#{gain}, t=#{t}"
        zero, pole, gain = bilinear(zero, pole, gain, t)
    end

    # p zero, pole, gain



    # [a, b, c, d]
end

butter(3.0, [0.2, 0.6], "high")