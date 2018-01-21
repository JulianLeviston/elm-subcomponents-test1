module Counter exposing (view, Model, init, intToModel, modelToInt, map)
import Html exposing (Html)
import Html.Attributes
import Html.Events
import Thunks

type alias Model = Thunks.Thunk Int

init : Model
init = intToModel 0

initWith : Int -> Model
initWith = intToModel

view : Model -> Html Model
view model =
    Html.div
        [ Html.Attributes.style [("border", "1px solid blue"), ("width", "100px"), ("padding", "2px")] ]
        [ Html.button
            [ Html.Events.onClick (mapSubtractOne model) ]
            [ Html.text "-" ]
        , Html.span
            []
            [ Html.text (toString <| modelToInt model) ]
        , Html.button
            [ Html.Events.onClick (mapAddOne model) ]
            [ Html.text "+" ]
        ]

mapAddOne : Model -> Model
mapAddOne = map (\x -> x + 1)

mapSubtractOne : Model -> Model
mapSubtractOne = map (\x -> x - 1)

intToModel : Int -> Model
intToModel = Thunks.thunkify

map : (Int -> Int) -> Model -> Model
map = Thunks.thunkMap

modelToInt : Model -> Int
modelToInt valueThunkFunction = valueThunkFunction ()
