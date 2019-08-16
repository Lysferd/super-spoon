
module CNPJ
  def self.factory
    n = Array::new( 12 ).map! { rand 10 }
    a = [ ]
    a[0] = n[11] * 2
    a[1] = n[10] * 3
    a[2] = n[9] * 4
    a[3] = n[8] * 5
    a[4] = n[7] * 6
    a[5] = n[6] * 7
    a[6] = n[5] * 8
    a[7] = n[4] * 9
    a[8] = n[3] * 2
    a[9] = n[2] * 3
    a[10] = n[1] * 4
    a[11] = n[0] * 5

    d1 = 11 - ( a.sum % 11 )
    d1 = 0 if d1 >= 10

    a = [ ]
    a[0] = d1 * 2
    a[1] = n[11] * 3
    a[2] = n[10] * 4
    a[3] = n[9] * 5
    a[4] = n[8] * 6
    a[5] = n[7] * 7
    a[6] = n[6] * 8
    a[7] = n[5] * 9
    a[8] = n[4] * 2
    a[9] = n[3] * 3
    a[10] = n[2] * 4
    a[11] = n[1] * 5
    a[12] = n[0] * 6

    d2 = 11 - ( a.sum % 11 )
    d2 = 0 if d2 >= 10

    cnpj = n << d1 << d2
    return "%d%d.%d%d%d.%d%d%d/%d%d%d%d-%d%d" % cnpj
  end
end

