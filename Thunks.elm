module Thunks exposing (Thunk, thunkify, thunkMap)

type alias Thunk a = () -> a

thunkMap : (a -> a) -> (() -> a) -> () -> a
thunkMap f getVal =
  let newVal = f (getVal ())
  in \_ -> newVal

thunkify : a -> () -> a
thunkify x = \_ -> x
