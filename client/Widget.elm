import Browser
-- import Time exposing (now)
import Task exposing (perform)
import Html exposing (Html, button, div, text, h1, h2, h3, h5, a, p, label, br, legend, span, img, ul, li, i)
import Html.Attributes exposing (class, style, type_, attribute, id, tabindex, href, target, src)
import Generated.Api exposing (Test, TestPair, getTestByCode)
import Http
import String exposing (fromInt)
import List as List exposing (map)
import Maybe exposing (map, withDefault)


main =
  Browser.element { init = init, update = update, subscriptions = subscriptions, view = view }


-- MODEL

type TestStatus
  = TestFailure Http.Error
  | Loading
  | Loaded Test

type alias Model = 
  { testStatus : TestStatus
  }

init : {} -> (Model, Cmd Msg)
init {} =
  ( { testStatus = Loading
    }
  , getTestByCode "https://localhost/test" (Just "this") GotTest
  )

-- UPDATE

type Msg
  = GotTest (Result Http.Error TestPair)

update : Msg -> Model -> (Model, Cmd Msg)
update msg ({ testStatus } as model) =
  case msg of
    GotTest result ->
      case result of
        Ok ({tpTest, tpInt})  ->
          ( {model | testStatus = Loaded tpTest}
          , Cmd.none
          )

        Err err ->
          ({model | testStatus = TestFailure err}, Cmd.none)

-- VIEW

view : Model -> Html Msg
view 
    { testStatus
    } =
  case testStatus of
    TestFailure err ->
      div []
        [ text ("Error of test getting: " ++ (errorToString err))]
    Loading ->
      div []
        [ text "Loading test" ]
    Loaded {testId, testName} ->
      div [] [
        div []
          [ text ("id: " ++ (fromInt testId)) ]
      , div []
          [ text ("name: " ++ testName) ]
        ]

errorToString err =
  case err of
    Http.BadUrl url              -> "Bad url: " ++ url
    Http.Timeout                 -> "Timeout"
    Http.NetworkError            -> "Network error"
    Http.BadStatus response      -> "Bad response status: " ++ (fromInt response)
    Http.BadBody str             -> "Bad response format: " ++ str

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none
