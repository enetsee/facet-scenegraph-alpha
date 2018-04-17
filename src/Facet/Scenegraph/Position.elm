module Facet.Scenegraph.Position
    exposing
        ( Position(PrimarySecondary, PrimaryExtent, SecondaryExtent, CenterExtent)
        , map
        )

{-|
@docs Position
@docs map
-}


{-| Possible encodings of a primary and secondary position
-}
type Position
    = PrimarySecondary Float Float
    | PrimaryExtent Float Float
    | SecondaryExtent Float Float
    | CenterExtent Float Float


{-| -}
map : (Float -> Float) -> Position -> Position
map f position =
    case position of
        PrimarySecondary x x2 ->
            PrimarySecondary (f x) (f x2)

        PrimaryExtent x extent ->
            PrimaryExtent (f x) extent

        SecondaryExtent x extent ->
            SecondaryExtent (f x) extent

        CenterExtent x extent ->
            CenterExtent (f x) extent
