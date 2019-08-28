module Generated.Api exposing(..)

import Json.Decode
import Json.Encode exposing (Value)
-- The following module comes from bartavelle/json-helpers
import Json.Helpers exposing (..)
import Dict exposing (Dict)
import Set
import Http
import String
import Url.Builder

maybeBoolToIntStr : Maybe Bool -> String
maybeBoolToIntStr mx =
  case mx of
    Nothing -> ""
    Just True -> "1"
    Just False -> "0"

type alias Test  =
   { testId: Int
   , testName: String
   }

jsonDecTest : Json.Decode.Decoder ( Test )
jsonDecTest =
   Json.Decode.succeed (\ptestId ptestName -> {testId = ptestId, testName = ptestName})
   |> required "testId" (Json.Decode.int)
   |> required "testName" (Json.Decode.string)

jsonEncTest : Test -> Value
jsonEncTest  val =
   Json.Encode.object
   [ ("testId", Json.Encode.int val.testId)
   , ("testName", Json.Encode.string val.testName)
   ]



type alias TestPair  =
   { tpTest: Test
   , tpInt: Int
   }

jsonDecTestPair : Json.Decode.Decoder ( TestPair )
jsonDecTestPair =
   Json.Decode.succeed (\ptpTest ptpInt -> {tpTest = ptpTest, tpInt = ptpInt})
   |> required "tpTest" (jsonDecTest)
   |> required "tpInt" (Json.Decode.int)

jsonEncTestPair : TestPair -> Value
jsonEncTestPair  val =
   Json.Encode.object
   [ ("tpTest", jsonEncTest val.tpTest)
   , ("tpInt", Json.Encode.int val.tpInt)
   ]


getTestByCode : String -> (Maybe String) -> (Result Http.Error  (TestPair)  -> msg) -> Cmd msg
getTestByCode capture_code query_locale toMsg =
    let
        params =
            List.filterMap identity
            (List.concat
                [ [ query_locale
                    |> Maybe.map (Url.Builder.string "locale") ]
                ])
    in
        Http.request
            { method =
                "GET"
            , headers =
                []
            , url =
                Url.Builder.crossOrigin ""
                    [ "test"
                    , capture_code
                    ]
                    params
            , body =
                Http.emptyBody
            , expect =
                Http.expectJson toMsg jsonDecTestPair
            , timeout =
                Nothing
            , tracker =
                Nothing
            }
