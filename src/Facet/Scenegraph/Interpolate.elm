module Facet.Scenegraph.Interpolate exposing (Interpolate(..))

{-|
@docs Interpolate
-}


{-| Interpolation methods. The methods are those offered by  [Vega] https://vega.github.io/vega/docs/marks/line/
    which in turn are base on methods implemented in  [D3](https://github.com/d3/d3-shape/blob/master/README.md#curves).
-}
type Interpolate
    = Linear
    | Basis
    | Bundle Float
    | Cardinal Float
    | CatmullRom Float
    | Monotone
    | Natural
    | Step
    | StepAfter
    | StepBefore
