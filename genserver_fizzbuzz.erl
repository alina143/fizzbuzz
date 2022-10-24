-module(genserver_fizzbuzz).

-behaviour(gen_server).

-export([start/0,
         init/1,
         handle_call/3,
         handle_cast/2,
         handle_info/2,
         terminate/2,
         buzz_func/2]).

-export([do_buzz/1]).

start() ->
  gen_server:start({local, ?MODULE}, ?MODULE, [], []).

init([]) ->
    {ok, []}.

do_buzz(Value) ->
  gen_server:call(?MODULE, {fizzbuzz, Value}).

handle_call({fizzbuzz, Value}, _From, State) ->
    {Reply, State2} = buzz_func(Value, State),
    {reply, Reply, State2};

handle_call(_Request, _From, State) ->
    {reply, ignored, State}.

handle_cast(_Msg, State) ->
    {noreply, State}.

handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

buzz_func(Count, State) ->
    case is_integer(Count) andalso Count > 0 of
        true -> 
            Div = Count div 15,
            Arr = fun(X) -> 
                    [X, X+1, fizz, X+3, buzz, X+5, X+6, X+7, fizz, buzz, X+10, bizz, X+12, X+13, fizzbuzz]
                end,
            Arr2 = fun(X) when X rem 3 == 0 -> fizz;
                    (X) when X rem 5 == 0 -> buzz;
                    (X) -> X + Div * 15
                    end,
            Part1 = lists:foldr(fun(N, Acc) ->
                    Arr(N * 15 + 1) ++ Acc
                end, [], lists:seq(0, Div - 1)),
            Part2 = [Arr2(N) || N <- lists:seq(1, Count rem 15)],
            {Part1 ++ Part2, [Count | State]};
        _ -> 
            case State of 
                [] -> {[], State};
                _ -> {lists:nth(1, State), State}
            end
    end.
