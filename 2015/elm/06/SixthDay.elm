module SixthDay where

import Array exposing (Array)
--import Maybe exposing (Maybe)
import String
--import Html


-- MODEL

type Command
  = TurnOn
  | TurnOff
  | Toggle

type alias Light =
  { x: Int, y: Int, lit: Bool}

type alias Operation =
  { startX: Int, startY: Int, endX: Int, endY: Int, command: Command}

type alias Model =
  Array (Array Light)

initialModel : Model
initialModel =
  Array.initialize 10 (\x -> Array.initialize 10 (\y -> Light x y False))

-- UPDATE

type Action
  = NoOp
  | Update String

update : Action -> Model -> Model
update action model =
  case action of
    NoOp -> model

    Update operation ->
      model

composeOperation : Command -> String -> String -> Operation
composeOperation command start end =
  let
    start' = splitLocation start
    end' = splitLocation end
  in
    Operation (fst start') (snd start') (fst end') (snd end') command


splitLocation : String -> ( Int, Int )
splitLocation location =
  let
    coords = String.split location ","
    x = case List.head coords of
      Just value -> value
      Nothing -> Debug.crash "Invalid case of X1."
    y = case (List.drop 1 coords |> List.head) of
      Just value -> value
      Nothing -> Debug.crash "Invalid case of Y1."
    xint = case String.toInt x of
      Ok value -> value
      Err value -> Debug.crash "Invalid case of X2."
    yint = case String.toInt y of
      Ok value -> value
      Err value -> Debug.crash "Invalid case of Y2."
  in
    (xint, yint)

snagWord : Int -> Array String -> String
snagWord position array =
  case Array.get position array of
    Just value -> value
    Nothing -> Debug.crash "Invalid case of Array flu."

parseOperation : String -> Operation
parseOperation input =
  let
    words = Array.fromList (String.words input)
  in
    if String.startsWith "turn on" input then
      composeOperation TurnOn (snagWord 2 words) (snagWord 4 words)
    else if String.startsWith "turn off" input then
      composeOperation TurnOff (snagWord 2 words) (snagWord 4 words)
    else
      composeOperation Toggle (snagWord 1 words) (snagWord 3 words)
