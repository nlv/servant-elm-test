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

type alias TestG a b =
   { testId: a
   , testName: b
   }

jsonDecTestG : Json.Decode.Decoder a -> Json.Decode.Decoder b -> Json.Decode.Decoder ( TestG a b )
jsonDecTestG localDecoder_a localDecoder_b =
   Json.Decode.succeed (\ptestId ptestName -> {testId = ptestId, testName = ptestName})
   |> required "testId" (localDecoder_a)
   |> required "testName" (localDecoder_b)

jsonEncTestG : (a -> Value) -> (b -> Value) -> TestG a b -> Value
jsonEncTestG localEncoder_a localEncoder_b val =
   Json.Encode.object
   [ ("testId", localEncoder_a val.testId)
   , ("testName", localEncoder_b val.testName)
   ]



type alias TestPairG a b =
   { tpTest: (TestG a b)
   , tpInt: Int
   }

jsonDecTestPairG : Json.Decode.Decoder a -> Json.Decode.Decoder b -> Json.Decode.Decoder ( TestPairG a b )
jsonDecTestPairG localDecoder_a localDecoder_b =
   Json.Decode.succeed (\ptpTest ptpInt -> {tpTest = ptpTest, tpInt = ptpInt})
   |> required "tpTest" (jsonDecTestG (localDecoder_a) (localDecoder_b))
   |> required "tpInt" (Json.Decode.int)

jsonEncTestPairG : (a -> Value) -> (b -> Value) -> TestPairG a b -> Value
jsonEncTestPairG localEncoder_a localEncoder_b val =
   Json.Encode.object
   [ ("tpTest", (jsonEncTestG (localEncoder_a) (localEncoder_b)) val.tpTest)
   , ("tpInt", Json.Encode.int val.tpInt)
   ]


getTestByCode : String -> (Maybe String) -> (Result Http.Error  ((TestPairG Int String))  -> msg) -> Cmd msg
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
                Http.expectJson toMsg jsonDec(TestPairG Int String)
            , timeout =
                Nothing
            , tracker =
                Nothing
            }
