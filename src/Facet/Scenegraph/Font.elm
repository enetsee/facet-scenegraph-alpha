module Facet.Scenegraph.Font exposing (Font, default, FontStyle(..), FontWeight(..))

{-|
@docs Font,  FontWeight, FontStyle
@docs default

-}


{-| Font styling
-}
type alias Font =
    { font : String
    , fontSize : Float
    , fontWeight : FontWeight
    , fontStyle : FontStyle
    }


{-| -}
type FontWeight
    = WeightNormal
    | WeightBold


{-| -}
type FontStyle
    = StyleNormal
    | StyleItalic


{-| -}
default : Font
default =
    Font "Helvetica" 12 WeightNormal StyleNormal
