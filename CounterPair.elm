module CounterPair exposing (Model, init, view, modelFromPairOfCounters, pairOfCountersFromModel, pairOfIntsFromModel)

import Html exposing (Html)
import Html.Attributes
import Html.Events
import Counter


type alias Model =
    { upperCounter : Counter.Model
    , lowerCounter : Counter.Model
    }


init : Model
init =
    { upperCounter = Counter.init
    , lowerCounter = Counter.init
    }


modelFromPairOfCounters : ( Counter.Model, Counter.Model ) -> Model
modelFromPairOfCounters ( counterA, counterB ) =
    { upperCounter = counterA, lowerCounter = counterB }


pairOfCountersFromModel : Model -> ( Counter.Model, Counter.Model )
pairOfCountersFromModel model =
    ( model.upperCounter, model.lowerCounter )


pairOfIntsFromModel : Model -> ( Int, Int )
pairOfIntsFromModel model =
    ( Counter.modelToInt model.upperCounter, Counter.modelToInt model.lowerCounter )


view : Model -> Html Model
view model =
    Html.div [ Html.Attributes.style [ ( "border", "1px solid gray" ), ( "width", "200px" ), ( "padding", "5px" ) ] ]
        [ Html.text "Pair of Counters:"
        , firstCounterView model
        , Html.button [ Html.Events.onClick { model | upperCounter = Counter.map (\x -> x * 2) model.upperCounter } ] [ Html.text "x 2" ]
        , secondCounterView model
        , Html.button [ Html.Events.onClick { model | upperCounter = model.lowerCounter, lowerCounter = model.upperCounter } ] [ Html.text "Flip States" ]
        ]


firstCounterView : Model -> Html Model
firstCounterView model =
    Html.map
        (\newCounterModel -> { model | upperCounter = newCounterModel })
        (Counter.view model.upperCounter)


secondCounterView : Model -> Html Model
secondCounterView model =
    Html.map
        (\newCounterModel -> { model | lowerCounter = newCounterModel })
        (Counter.view model.lowerCounter)
