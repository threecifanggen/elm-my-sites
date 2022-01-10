module Message.Message exposing (..)

import Message.Home as Home
import Message.Url as Url

type Msg = HomeMsg Home.Msg
  | UrlMsg Url.Msg

