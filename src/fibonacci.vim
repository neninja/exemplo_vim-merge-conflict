function Fibonacci(n)
    let a = 0
    let b = 1
    let c = a:n

    if a:n < 2
        return a:n
    endif

    for i in range(2, a:n)
        let c = a + b
        let a = b
        let b = c
    endfor

    return c
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
