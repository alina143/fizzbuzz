-module(fizz_test).

-include_lib("eunit/include/eunit.hrl").


new_test() ->
    [?assertEqual(genserver_fizzbuzz:buzz_func(0, []), {[], []}),
    ?assertEqual(genserver_fizzbuzz:buzz_func(-5, []), {[], []}),
    ?assertEqual(genserver_fizzbuzz:buzz_func(1, []), {[1], [1]}),
    ?assertEqual(genserver_fizzbuzz:buzz_func(3, []), {[1, 2, fizz], [3]}),
    ?assertEqual(genserver_fizzbuzz:buzz_func(15, []), {[1,2,fizz,4,buzz,6,7,8,fizz,buzz,11,bizz,13,14,fizzbuzz], [15]}),
    ?assertEqual(genserver_fizzbuzz:buzz_func(16, []), {[1,2,fizz,4,buzz,6,7,8,fizz,buzz,11,bizz,13,14,fizzbuzz,16], [16]})
    ].