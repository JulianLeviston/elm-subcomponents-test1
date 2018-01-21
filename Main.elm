module Main exposing (main)

import Html exposing (Html)
import Html.Events
import Counter
import CounterPair

main =
    Html.beginnerProgram
         { view = view
         , update = update
         , model = init
         }

type alias Model =
  { counterAOfUpperCounterPair : Counter.Model
  , counterBOfUpperCounterPair : Counter.Model
  , counter : Counter.Model
  , lowerCounterPair : CounterPair.Model
  }

init : Model
init =
   { counterAOfUpperCounterPair = Counter.init
   , counterBOfUpperCounterPair = Counter.init
   , counter = Counter.init
   , lowerCounterPair = CounterPair.init
   }

cycleCountersDown : Model -> Model
cycleCountersDown model =
 { model |
    counterAOfUpperCounterPair = model.counter,
    counterBOfUpperCounterPair = model.counterAOfUpperCounterPair,
    counter = model.counterBOfUpperCounterPair
  }

update : Model -> Model -> Model
update newModel _ = newModel

view : Model -> Html Model
view model =
    Html.div []
    [ counterPairViewUpper model
    , upperCounterPairMultiplicationSumView model
    , counterView model
    , cycleCountersButton model
    , counterPairViewLower model
    ]

upperCounterPairMultiplicationSumView : Model -> Html Model
upperCounterPairMultiplicationSumView model =
  let
    intA = Counter.modelToInt model.counterAOfUpperCounterPair
    intB = Counter.modelToInt model.counterBOfUpperCounterPair
  in
    Html.div [] [ Html.text <| toString intA ++ " times " ++ toString intB ++ " equals " ++ (toString <| intA * intB)]

counterPairViewUpper : Model -> Html Model
counterPairViewUpper model =
  Html.map
    (\newCounterPairModel ->
      case CounterPair.pairOfCountersFromModel newCounterPairModel of
        (firstCounter, secondCounter) ->
          { model | counterAOfUpperCounterPair = firstCounter, counterBOfUpperCounterPair = secondCounter })
    (CounterPair.view <| CounterPair.modelFromPairOfCounters (model.counterAOfUpperCounterPair, model.counterBOfUpperCounterPair))

counterPairViewLower : Model -> Html Model
counterPairViewLower model =
  Html.map
    (\newCounterPairModel ->
      { model | lowerCounterPair = newCounterPairModel })
    (CounterPair.view model.lowerCounterPair)

counterView : Model -> Html Model
counterView model =
  Html.map
    (\newCounterModel -> { model | counter = newCounterModel })
    (Counter.view model.counter)

cycleCountersButton : Model -> Html Model
cycleCountersButton model =
  Html.button [ Html.Events.onClick (cycleCountersDown model) ] [ Html.text "Cycle Down" ]


