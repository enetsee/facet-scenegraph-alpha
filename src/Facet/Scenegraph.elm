module Facet.Scenegraph exposing (Scenegraph(..), ViewBox)

{-|
@docs Scenegraph, ViewBox
-}

import Facet.Scenegraph.Mark exposing (Arc, Area, Group, Line, Path, Polygon, Rect, Rule, Symbol, Text, Trail)


{-| A data structure representing a set of visual marks.
-}
type Scenegraph
    = Arc (List Arc)
    | Area (List Area)
    | Group (List ( Group, List Scenegraph ))
    | Line (List Line)
    | Path (List Path)
    | Polygon (List Polygon)
    | Rect (List Rect)
    | Rule (List Rule)
    | Symbol (List Symbol)
    | Text (List Text)
    | Trail (List Trail)


{-| Control how a scenegraph is displayed once rendered
-}
type alias ViewBox =
    { x : Float
    , y : Float
    , width : Float
    , height : Float
    }
