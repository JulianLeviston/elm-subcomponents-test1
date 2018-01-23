module Thunks exposing (Thunk, thunkify, thunkMap)


type alias Thunk a =
    () -> a


thunkMap : (a -> a) -> (() -> a) -> () -> a
thunkMap f getVal =
    let
        unthunkedValue =
            getVal ()
    in
        \_ -> f unthunkedValue


thunkify : a -> () -> a
thunkify x =
    \_ -> x
