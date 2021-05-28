require "matrix"

def postpad(x, l, c=0, dim=nil)
    x = Matrix.columns([x])
    nd = 2 #ndims
    sz = Vector[x.column_size, x.row_size]
    # if !dim
        
    # else

    # end
end

# postpad([1, 2], 4)

class Vector
    def >(f)
        self.map{|e| e > f ? 1 : 0}
    end

    def >=(f)
        self.map{|e| e >= f ? 1 : 0}
    end

    def <(f)
        self.map{|e| e < f ? 1 : 0}
    end

    def <=(f)
        self.map{|e| e >= f ? 1 : 0}
    end
end

p Vector[1, 2] > 1