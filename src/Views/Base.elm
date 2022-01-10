module Views.Base exposing (..)

import Bulma.Components exposing (..)
import Bulma.Layout exposing (..)
import Bulma.Modifiers exposing(..)
import Bulma.CDN exposing (stylesheet)
import Html exposing (Html, img, text, span, div)
import Html.Attributes exposing(src)
import Message.Home exposing (Msg)


baseFooter : Html msg
baseFooter
  = footer []
    [ container []
      [ content [ textCentered ]
        [ p [] 
          [ text "Ask your doctor if Bulma is right for you."
          ]
        ]
      ]
    ]
baseNavbarBurger : Html Msg
baseNavbarBurger 
  = navbarBurger isMenuOpen []
    [ span [] []
    , span [] []
    , span [] []
    ]

baseNavbarLink : Html Msg
baseNavbarLink 
  = navbarLink [] 
    [ text "More Junk" 
    ]

baseNavbar: Bool -> Bool -> Html Msg
baseNavbar isMenuOpen isMenuDropdownOpen
  = navbar navbarModifiers []
    [ navbarBrand [] navbarBurger
      [ navbarItem False []
        [ img [ src "https://B.io/images/bulma-logo.png" ] []
        ]
      ]
    , navbarMenu isMenuOpen []
      [ navbarStart [] 
        [ navbarItemLink False [] [ text "Home"  ]
        , navbarItemLink False [] [ text "Blog"    ]
        , navbarItemLink True  [] [ text "Carrots" ]
        , navbarItemLink False [] [ text "About"   ]
        ]
      , navbarEnd [] 
        [ navbarItemDropdown isMenuDropdownOpen Down [] baseNavbarLink
          [ navbarDropdown False Left [] 
            [ navbarItemLink False [] [ text "Crud"     ]
            , navbarItemLink False [] [ text "Detritus" ]
            , navbarItemLink True  [] [ text "Refuse"   ]
            , navbarItemLink False [] [ text "Trash"    ]
            ]
          ]
        ]
      ]
    ]

basePage: Bool -> Bool -> List(Html Msg) -> Html Msg
basePage isMenuOpen isMenuDropdownOpen contents
    = div []
    [ stylesheet
    , baseNavbar isMenuOpen isMenuDropdownOpen
    , div [] contents
    , baseFooter
    ]