module Views.Home exposing (..)

import Html exposing (div, text, Html)

import Message.Home exposing (Msg)
import Models.Home exposing (Model)
import Bulma.Components exposing (..)
import Bulma.Layout exposing (..)
import Bulma.Modifiers exposing(..)

homeView : Model -> Html Msg
homeView _ = div [] [
    text "Hello World"]