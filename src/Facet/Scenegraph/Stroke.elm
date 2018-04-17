module Facet.Scenegraph.Stroke
    exposing
        ( Stroke
        , StrokeDash(..)
        , StrokeLineCap(..)
        , StrokeLineJoin(..)
        , empty
        , strokeDashArray
        , strokeDashOffset
        )

{-|
@docs Stroke, StrokeDash, StrokeLineCap, StrokeLineJoin, empty
@docs strokeDashArray , strokeDashOffset
-}

import Color exposing (Color)


{-| Stroke styling
-}
type alias Stroke =
    { stroke : Maybe Color
    , strokeOpacity : Maybe Float
    , strokeWidth : Maybe Float
    , strokeLineCap : Maybe StrokeLineCap
    , strokeDash : Maybe StrokeDash
    , strokeLineJoin : Maybe StrokeLineJoin
    }


{-| A set of stroke dash arrays. `StrokeDash1` through `StrokeDash10` correspond
    to these [examples](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/stroke-dasharray).
    You may specify a custom stroke dash array using `StrokeDashCustom`.
    The first argument to each constructor is the offset
-}
type StrokeDash
    = StrokeDash1 (Maybe Float)
    | StrokeDash2 (Maybe Float)
    | StrokeDash3 (Maybe Float)
    | StrokeDash4 (Maybe Float)
    | StrokeDash5 (Maybe Float)
    | StrokeDash6 (Maybe Float)
    | StrokeDash7 (Maybe Float)
    | StrokeDash8 (Maybe Float)
    | StrokeDash9 (Maybe Float)
    | StrokeDash10 (Maybe Float)
    | StrokeDashCustom (List Float) (Maybe Float)


{-| Extract the stroke dash array from a `StrokeDash`
-}
strokeDashArray : StrokeDash -> List Float
strokeDashArray strokeDash =
    case strokeDash of
        StrokeDash1 _ ->
            [ 5, 5 ]

        StrokeDash2 _ ->
            [ 5, 10 ]

        StrokeDash3 _ ->
            [ 10, 5 ]

        StrokeDash4 _ ->
            [ 5, 1 ]

        StrokeDash5 _ ->
            [ 1, 5 ]

        StrokeDash6 _ ->
            [ 0.9 ]

        StrokeDash7 _ ->
            [ 15, 10, 5 ]

        StrokeDash8 _ ->
            [ 15, 10, 5, 10 ]

        StrokeDash9 _ ->
            [ 15, 10, 5, 10, 15 ]

        StrokeDash10 _ ->
            [ 5, 5, 1, 5 ]

        StrokeDashCustom xs _ ->
            xs


{-| Extract the stroke dash offset (if any) from a `StrokeDash`
-}
strokeDashOffset : StrokeDash -> Maybe Float
strokeDashOffset strokeDash =
    case strokeDash of
        StrokeDash1 maybeOffset ->
            maybeOffset

        StrokeDash2 maybeOffset ->
            maybeOffset

        StrokeDash3 maybeOffset ->
            maybeOffset

        StrokeDash4 maybeOffset ->
            maybeOffset

        StrokeDash5 maybeOffset ->
            maybeOffset

        StrokeDash6 maybeOffset ->
            maybeOffset

        StrokeDash7 maybeOffset ->
            maybeOffset

        StrokeDash8 maybeOffset ->
            maybeOffset

        StrokeDash9 maybeOffset ->
            maybeOffset

        StrokeDash10 maybeOffset ->
            maybeOffset

        StrokeDashCustom _ maybeOffset ->
            maybeOffset


{-| Specify the shape to be used at the end of open subpaths when they are stroked.
-}
type StrokeLineCap
    = CapButt
    | CapRound
    | CapSquare


{-| Specify the shape to be used at the corners of paths or basic shapes when they are stroked.
-}
type StrokeLineJoin
    = JoinMiter Float
    | JoinRound
    | JoinBevel


{-| The empty stroke
-}
empty : Stroke
empty =
    { stroke = Nothing
    , strokeOpacity = Nothing
    , strokeWidth = Nothing
    , strokeLineCap = Nothing
    , strokeDash = Nothing
    , strokeLineJoin = Nothing
    }
