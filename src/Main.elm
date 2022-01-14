module Main exposing (..)

import Browser

import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Url
import Views.Home exposing (homeView)
import Html.Events exposing (onMouseUp)
import Http

main : Program () Model Msg
main =
  Browser.application
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    , onUrlChange = UrlChanged
    , onUrlRequest = LinkClicked
    }



-- MODEL

type alias Model =
  { key : Nav.Key
  , url : Url.Url
  , blogMenuClass : String
  }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
  ( Model key url "navbar-item is-boxed is-hoverable", Cmd.none )



-- UPDATE


type Msg
  = LinkClicked Browser.UrlRequest
  | UrlChanged Url.Url
  | MouseOnBlogMenu



update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    LinkClicked urlRequest ->
      case urlRequest of
        Browser.Internal url ->
          ( model, Nav.pushUrl model.key (Url.toString url) )

        Browser.External href ->
          ( model, Nav.load href )

    UrlChanged url ->
      ( { model | url = url }
      , Cmd.none
      )

    MouseOnBlogMenu ->
      ( {model | blogMenuClass = "navbar-item is-boxed is-hoverable is-active"}
        , Cmd.none)



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
  Sub.none



-- VIEW

baseHeader : Html Msg
baseHeader = nav [ class "level" ] [
  p [ class "level-item", class "has-text-centered"] [
    a [ href "https://3gee.me", class "link", class "is-info"] [ text "Home" ]]
  , p [ class "level-item", class "has-text-centered"] [
    a [ href "https://workwiki.3gee.me", class "link", class "is-info"] [ text "工作知识库" ]]
  , p [ class "level-item", class "has-text-centered"] [
    img [ src "./assets/logo/3gee-logo.png", class "image", class "is-48x48"] []
    ]
  , p [ class "level-item", class "has-text-centered"] [
    a [ href "https://blog.3gee.me", class "link", class "is-info"] [ text "博客" ]]
  , p [ class "level-item", class "has-text-centered"] [
    a [ href "https://blog.3gee.me/about/", class "link", class "is-info"] [ text "About" ]]]

baseFooter : Html Msg
baseFooter = footer [class "footer", class "has-background-grey-dark"] [
  div [class "content has-text-centered", id "footer-info"] [
    p [ class "has-text-grey-lighter" ] [
      text "本网站由Elm"
      , span [] [img [src "./assets/img/elm.svg", class "image", class "is-16x16" ] [] ]
      , text "和Bulma"
      , span [] [img [src "./assets/img/bulma.svg", class "image", class "is-16x16" ] [] ]
      ,text "构建"],
    p [ class "has-text-grey-light" ] [text "©所有内容版权归黄宝臣(AKA 3gee)所有"]]]

socialFooter : Html Msg
socialFooter = footer [ class "footer"] [
  div [class "container"] [
    div [class "footer-title"] [ 
      p [ class "has-text-centered", class "title"] [ text "社交网络"]
    ]
    , br [] []
    , br [] []
    , br [] []
    , div [ class "columns", class "mx-4", id "footer-social-column", class "px-4", class "has-text-centered" ] [
      div [ class "column", class "has-text-centered" ] [
        a [ href "https://www.zhihu.com/people/huang-bao-chen"] [figure [class "image", class "is-96x96"] [ img [ src "./assets/img/zhihu.svg", class "has-text-centered"] [] ]
        , p [ class "subtitle"] [ text "知乎"]]
      ]
      , div [ class "column", class "has-text-centered" ] [
        a [ href "https://www.kaggle.com/threecifanggen"] [figure [class "image", class "is-96x96"] [ img [ src "./assets/img/kaggle.svg", class "has-text-centered"] [] ]
        , p [ class "subtitle"] [ text "KAGGLE"]]
      ]
      , div [ class "column", class "has-text-centered" ] [
        a [ href "https://github.com/threecifanggen"] [figure [class "image", class "is-96x96"] [ img [ src "./assets/img/github.svg", class "has-text-centered"] [] ]
        , p [ class "subtitle"] [ text "GitHub"]]
      ]
      , div [ class "column", class "has-text-centered" ] [
        a [ href "https://www.linkedin.cn/injobs/in/huang-baochen-84b58347"] [figure [class "image", class "is-96x96"] [ img [ src "./assets/img/linkedin.svg", class "has-text-centered"] [] ]
        , p [ class "subtitle"] [ text "LinkedIn"]]
      ]
      , div [ class "column", class "has-text-centered" ] [
        a [ href "https://stackoverflow.com/users/5387442/huang-baochen"] [figure [class "image", class "is-96x96"] [ img [ src "./assets/img/stackoverflow.svg", class "has-text-centered"] [] ]
        , p [ class "subtitle"] [ text "StackOverFlow"]]
      ]
    ]]]

cardTemplate : String -> (String, String) ->  List(Html msg) -> List(String, String) -> Html msg
cardTemplate projectImage cardTitle description footerList =
  div [ class "card" ] [
  div [ class "card-image" ] [
    figure [class "image", class "is-1by1"] [
      img [ src projectImage] []
    ]
  ]
  , div [ class "card-content" ] [
    div [ class "media"] [div [ class "media-content" ] [
     h1 [class "title", class "is-4"] [text (cardTitle |> Tuple.first) ]
     , p [class "subtitle", class "is-6"] [text (cardTitle |> Tuple.second)]]]
    , div [ class "content"] description]
  , footer [ class "card-footer"] 
    (footerList |> List.map (\x -> a [ href (Tuple.first x), class "card-footer-item"] [ text (Tuple.second x) ]))]

fppyCard : Html msg
fppyCard = cardTemplate 
    "./assets/img/fppy-learn.jpg"
    ("fppy-learn", "函数式编程的Python实现") 
    [ code [] [text "fppy-learn"],
      text "是一个基于Python实现的函数式编程包，里面囊括了常见的惰性列表、Y组合子、Monad、无副作用随机数生成器等特性。"]
    [("https://pypi.org/project/fppy-learn/", "PYPI"), ("https://github.com/threecifanggen/python-functional-programming", "GitHub")]

dsLearnCard : Html msg
dsLearnCard = cardTemplate 
    "./assets/img/data-science-learning.jpg"
    ("data-science-learning", "数据科学相关的学习资料") 
    [ text "这是一个数据分析、数据工程等各种文献、书籍的阅读笔记，里面也有",
      code [] [text "jupyter notebook"],
      text "相关的的实现，开源方便大家一同学习进步。"]
    [("https://github.com/threecifanggen/data-science-learning", "GitHub")]

artUniverseCard : Html msg
artUniverseCard = cardTemplate 
    "./assets/img/arts-from-universe.jpg"
    ("arts-from-universe.", "计算机艺术") 
    [ text "通过GAN、MIDI等工具实现一些计算机艺术，视图从另一个视角理解艺术和宇宙，代码由Python和Rust实现。"]
    [ ("https://github.com/threecifanggen/arts-from-universe", "GitHub")
      , ("https://opensea.io/collection/arts-from-universe", "OpenSea")]

blogTileView : String -> String -> String -> List(Html Msg)
blogTileView blogTitle blogUrl blogDescription = [
    p [ class "title", class "is-4", class "has-text-centered" ] [ a [ href blogUrl, class "has-text-primary-light" ]  [ text blogTitle ]]
    , br [] []
    , p [ class "subtitle", class "is-6", class "has-text-primary-light", class "has-text-centered" ] [text blogDescription]]

view : Model -> Browser.Document Msg
view model =
  { title = "3GEE的主站"
  , body =
      [
        br [] []
        , baseHeader
        , section [class "section", class "is-large", class "has-background-info"] [
          div [class "container"] [
          h1 [class "title", class "has-text-primary-light", class "has-text-centered"] [text "欢迎来到我的主页"]
          , div [class "block"] [
            h2 [class "subtitle", class "block", class "has-text-primary-light", class "has-text-centered"] [text "这里汇总了我在网络世界的大部分创作和痕迹。"]
          ]
        ]]
        , section [class "section", class "is-large", class "has-background-light"] [
          h1 [class "title", class "has-text-centered", class "has-text-grey-darker"] [text "我的开源项目"]
          , br [] []
          , div [class "container"] [
            div [class "columns"] [
              div [ class "column" ] [fppyCard]
              , div [ class "column" ] [dsLearnCard]
              , div [ class "column" ] [artUniverseCard]
            ]
          ]
        ]
        , section [ class "section", class "is-large", class "has-background-info"] [
          div [class "container"] [
            h1 [ class "title", class "has-text-primary-light", class "has-text-centered" ] [text "我的博客/专栏" ]
            , div [ class "block" ] [
              h2 [ class "subtitle", class "block", class "has-text-primary-light", class "has-text-centered" ] [
                text "因为爱好广泛，在这里维护了三个不同的播客主题，分别是DS/CS，电影和哲学。"]]
            , br [] []
            , br [] []
            , div [ class "tile", class "is-ancestor"] [
              div [ class "tile", class "is-6", class "is-vertical", class "is-parent" ] [
                div [ class "tile", class "is-child", class "is-box"] (blogTileView "λ&τ" "https://blog.3gee.me/categories/lambda-and-tau.html" "一个函数式编程和数据科学相关的博客")
                , div [ class "tile", class "is-child", class "is-box"] (blogTileView "过度解读" "https://blog.3gee.me/categories/%E8%BF%87%E5%BA%A6%E8%A7%A3%E8%AF%BB.html" "艺术（主要以电影为主）的博客")
                , div [ class "tile", class "is-child", class "is-box"] (blogTileView "哲·叠" "https://blog.3gee.me/categories/phold.html" "哲学相关的博客")]
              , div [ class "tile", class "is-6", class "is-child"] [
                p [ class "title", class "is-4", class "has-text-centered" ] [ a [ href "https://blog.3gee.me/photos/", class "has-text-primary-light" ]  [ text "我的摄影集" ]]
                , figure [ class "image", class "is-5by3" ] [ img [ src "./assets/img/photo-albums-pic.jpg" ] []]
              ]]]]
        , div [ class "is-hidden" ] [
          text "The current URL is: "
          , b [] [ text (Url.toString model.url) ]]
        , socialFooter
        , baseFooter
      ]
  }

viewLink : String -> String -> Html msg
viewLink path viewName =
  div [ class "navbar-item"] [ a [href path] [text viewName]]