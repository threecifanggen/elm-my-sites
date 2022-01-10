module Views.View exposing (..)
import Views.Home exposing (homeView)
import Views.Base exposiong (basePage)
import Html exposing (Html)
import Models.Model exposing (Model)

view : Model -> Html Msg
view model = 
    case model