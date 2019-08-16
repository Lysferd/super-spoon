
module CPF
  def self.factory
    n = Array::new( 9 ).map! { rand 10 }
  
    a = [ ]
    a[0] = n[8] * 2
    a[1] = n[7] * 3
    a[2] = n[6] * 4
    a[3] = n[5] * 5
    a[4] = n[4] * 6
    a[5] = n[3] * 7
    a[6] = n[2] * 8
    a[7] = n[1] * 9
    a[8] = n[0] * 10

    d1 = 11 - ( a.sum % 11 )
    d1 = 0 if d1 >= 10

    a = [ ]
    a[0] = d1 * 2
    a[1] = n[8] * 3
    a[2] = n[7] * 4
    a[3] = n[6] * 5
    a[4] = n[5] * 6
    a[5] = n[4] * 7
    a[6] = n[3] * 8
    a[7] = n[2] * 9
    a[8] = n[1] * 10
    a[9] = n[0] * 11

    d2 = 11 - ( a.sum % 11 )
    d2 = 0 if d2 >= 10

    cpf = n << d1 << d2
    return "%d%d%d.%d%d%d.%d%d%d-%d%d" % cpf
  end
end

