function Fibonacci(n)
    " ...
    return 0
endfunction

let tdt = [
            \ [ 0,  0 ],
            \ [ 1,  1 ],
            \ [ 2,  1 ],
            \ [ 3,  2 ],
            \ [ 4,  3 ],
            \ [ 5,  5 ],
            \ [ 6,  8 ],
            \ [ 7,  13 ],
            \ [ 8,  21 ],
            \ [ 9,  34 ],
            \ [ 10, 55 ],
            \ ]

for scenario in tdt
    let input = scenario[0]
    let want = scenario[1]
    let got = Fibonacci(input)
    call assert_equal(want, got)
endfor

if len(v:errors) > 0
    echo v:errors
endif
