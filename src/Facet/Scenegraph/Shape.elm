module Facet.Scenegraph.Shape exposing (Shape(..))

{-|
@docs Shape
-}

import Path.LowLevel exposing (SubPath)


{-| A set of predefined shapes and custom SVG paths. When using `Custom`, the
    SVG path should have a bounding box of  (-0.5,0.5), (-0.5,0.5) in order
    to render consistently with built in shapes.
-}
type Shape
    = Circle
    | Square
    | Cross
    | Diamond
    | TriangleUp
    | TriangleDown
    | TriangleRight
    | TriangleLeft
    | Arrow
    | Custom SubPath
