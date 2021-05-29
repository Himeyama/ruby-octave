require "matrix"
require "../matruby/ary.rb"
require "../matruby/find.rb"
require "../matruby/isscalar.rb"
require "../matruby/fix.rb"
require "../matruby/mat.rb"

def postpad(x, l, c=0, dim=nil)
    x = Matrix[x]
    nd = 2 #ndims
    sz = Vector[x.row_size, x.column_size]

    if !dim
        (dim = find(sz > 1, 1)) || dim = 0
    else
        # エラー
    end

    if !(isscalar(l) == 1 || l < 0)
        $stderr.puts("エラー")
        exit false
    end

    if(dim > nd)
        sz[nd..dim] = 1
    end

    d = sz[dim]    

    if d == l
        y = x
    elsif d >= l
        idx = repmat()
        $stderr.puts "未実装"
        exit false
    else
        sz[dim] = l - d
        y = cat(dim, x, c*ones(sz))
    end
    y
end