module Facet.Scenegraph.Fill exposing (Fill, empty)

{-|
@docs Fill,empty
-}

import Color exposing (Color)


{-| Fill styling
-}
type alias Fill =
    { fill : Maybe Color
    , fillOpacity : Maybe Float
    }


{-| The empty fill
-}
empty : Fill
empty =
    Fill Nothing Nothing
