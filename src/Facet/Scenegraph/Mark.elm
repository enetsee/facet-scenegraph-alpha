module Facet.Scenegraph.Mark
    exposing
        ( Arc
        , arc
        , startAngle
        , endAngle
        , padAngle
        , innerRadius
        , outerRadius
        , Area
        , Orientation(..)
        , hArea
        , vArea
        , Group
        , group
        , clip
        , Line
        , line
        , Path
        , path
        , Polygon
        , polygon
        , Rect
        , rect
        , rectWidthHeight
        , Rule
        , rule
        , Symbol
        , symbol
        , shape
        , size
        , Text
        , Direction(..)
        , Baseline(..)
        , Align(..)
        , text
        , relativePosition
        , align
        , baseline
        , direction
        , font
        , fontName
        , fontWeight
        , fontWeightBold
        , fontWeightNormal
        , fontStyle
        , fontStyleItalic
        , fontStyleNormal
        , Trail
        , trail
        , FilledMark
        , fill
        , fillColor
        , fillOpacity
        , StrokedMark
        , stroke
        , strokeColor
        , strokeWidth
        , strokeOpacity
        , strokeDash
        , strokeLineCap
        , strokeLineCapButt
        , strokeLineCapRound
        , strokeLineCapSquare
        , strokeLineJoin
        , strokeLineJoinMiter
        , strokeLineJoinRound
        , strokeLineJoinBevel
        , angle
        , cornerRadius
        , LineLike
        , Behaviour(..)
        , interpolate
        , behaviour
        , Mark
        , href
        , tooltip
        )

{-|
# Static encodings of visual marks

## Arc
@docs  Arc, arc, startAngle , endAngle , padAngle , innerRadius , outerRadius

## Area
@docs Area,Orientation, hArea, vArea

## Group
@docs Group, group, clip

## Line
@docs Line, line

## Line-like
@docs Behaviour, LineLike, interpolate, behaviour

## Path
@docs Path, path

## Polygon
@docs Polygon,  polygon

## Rect
@docs Rect , rect, rectWidthHeight

## Rule
@docs Rule, rule

## Symbol
@docs Symbol, symbol, shape, size

## Text
@docs Text, Direction, Align, Baseline, text, relativePosition, align, baseline, direction, font , fontName , fontWeight, fontWeightBold, fontWeightNormal, fontStyle, fontStyleItalic, fontStyleNormal

## Trail
@docs Trail , trail

## Fill
@docs FilledMark, fill, fillColor, fillOpacity

## Stroke
@docs StrokedMark, stroke, strokeColor, strokeWidth, strokeOpacity, strokeDash, strokeLineCap, strokeLineCapButt, strokeLineCapRound, strokeLineCapSquare, strokeLineJoin, strokeLineJoinBevel, strokeLineJoinMiter, strokeLineJoinRound

## Miscellaneous
@docs angle, cornerRadius

## General
@docs Mark, href, tooltip
-}

import Color exposing (Color)
import Facet.Scenegraph.Cursor exposing (Cursor(CursorDefault))
import Facet.Scenegraph.Fill as Fill exposing (Fill)
import Facet.Scenegraph.Font as Font exposing (Font)
import Facet.Scenegraph.Interpolate exposing (Interpolate)
import Facet.Scenegraph.Position exposing (Position(..))
import Facet.Scenegraph.Shape as Shape exposing (Shape)
import Facet.Scenegraph.Stroke as Stroke exposing (Stroke, StrokeDash)
import Path.LowLevel exposing (SubPath)


-- Arcs ------------------------------------------------------------------------


{-| Circular arc
-}
type alias Arc =
    { startAngle : Float
    , endAngle : Float
    , padAngle : Float
    , innerRadius : Float
    , outerRadius : Float
    , cornerRadius : Float
    , x : Float
    , y : Float
    , fill : Fill
    , stroke : Stroke
    , cursor : Cursor
    , href : Maybe String
    , tooltip : Maybe String
    }


{-| Create an `Arc` mark from x position, y position, start angle
    and end angle.
-}
arc : Float -> Float -> Float -> Float -> Arc
arc x y startAngle endAngle =
    Arc
        startAngle
        endAngle
        0
        0
        0
        0
        x
        y
        Fill.empty
        Stroke.empty
        CursorDefault
        Nothing
        Nothing


{-| Set the start angle of an `Arc` mark.
-}
startAngle : Float -> Arc -> Arc
startAngle angle arc =
    { arc | startAngle = angle }


{-| Set the end angle of an `Arc` mark.
-}
endAngle : Float -> Arc -> Arc
endAngle angle arc =
    { arc | endAngle = angle }


{-| Set the pad angle of an `Arc` mark.
-}
padAngle : Float -> Arc -> Arc
padAngle angle arc =
    { arc | padAngle = angle }


{-| Set the inner radius of an `Arc` mark.
-}
innerRadius : Float -> Arc -> Arc
innerRadius radius arc =
    { arc | innerRadius = radius }


{-| Set the outer radius of an `Arc` mark.
-}
outerRadius : Float -> Arc -> Arc
outerRadius radius arc =
    { arc | outerRadius = radius }



-- Area ------------------------------------------------------------------------


{-| The rendering behaviour when a missing value is encountered:
    - `SkipMissing` will ignore the missing value and continue with the current path;
    - `BeginNew` will begin a new path.
-}
type Behaviour
    = SkipMissing
    | BeginNew


{-| Orient the area mark vertically or horizontally.
-}
type Orientation
    = Vertical
    | Horizontal


{-| Filled area with either vertical or horizontal orientation.
-}
type alias Area =
    { x : List (Maybe Float)
    , y : List (Maybe Position)
    , interpolate : Interpolate
    , behaviour : Behaviour
    , orientation : Orientation
    , fill : Fill
    , stroke : Stroke
    , cursor : Cursor
    , href : Maybe String
    , tooltip : Maybe String
    }


{-| Create a horitontally oriented area mark from x positions, upper and lower
    y positions, interpolation method and missing value behaviour.
-}
hArea : List Float -> List Float -> List Float -> Interpolate -> Behaviour -> Area
hArea xs ys ys2 interpolate behaviour =
    Area (List.map Just xs)
        (List.map2 (\x x2 -> PrimarySecondary x x2 |> Just) ys ys2)
        interpolate
        behaviour
        Horizontal
        Fill.empty
        Stroke.empty
        CursorDefault
        Nothing
        Nothing


{-| Create a vertically oriented area mark from y positions, upper and lower
    x positions, interpolation method and missing value behaviour.
-}
vArea : List Float -> List Float -> List Float -> Interpolate -> Behaviour -> Area
vArea ys xs xs2 interpolate behaviour =
    Area (List.map Just ys)
        (List.map2 (\x x2 -> PrimarySecondary x x2 |> Just) xs xs2)
        interpolate
        behaviour
        Vertical
        Fill.empty
        Stroke.empty
        CursorDefault
        Nothing
        Nothing



-- Group -----------------------------------------------------------------------


{-| Container for other marks.
-}
type alias Group =
    { clip : Bool
    , cornerRadius : Float
    , x : Float
    , y : Float
    , width : Float
    , height : Float
    , fill : Fill
    , stroke : Stroke
    , cursor : Cursor
    , href : Maybe String
    , tooltip : Maybe String
    }


{-| Create a `Group` mark from x position, width, y position, height and
    clip flag.
-}
group : Float -> Float -> Float -> Float -> Bool -> Group
group x width y height clip =
    Group
        clip
        0
        x
        y
        width
        height
        Fill.empty
        Stroke.empty
        CursorDefault
        Nothing
        Nothing


{-| Set the clip flag of a `Rect` mark. Setting this to true will create a
    rectangular clip path (with position and dimensions determined by those
    defined for the mark) and apply to all contained marks.
-}
clip : Bool -> Group -> Group
clip clip group =
    { group | clip = clip }



-- Line ------------------------------------------------------------------------


{-| Stroked lines.
-}
type alias Line =
    { x : List (Maybe Float)
    , y : List (Maybe Float)
    , interpolate : Interpolate
    , behaviour : Behaviour
    , stroke : Stroke
    , cursor : Cursor
    , href : Maybe String
    , tooltip : Maybe String
    }


{-| Create a `Line` mark from x positions, y positions, interpolation method
    and missing value behaviour.
-}
line : List Float -> List Float -> Interpolate -> Behaviour -> Line
line xs ys interpolate behaviour =
    Line
        (List.map Just xs)
        (List.map Just ys)
        interpolate
        behaviour
        Stroke.empty
        CursorDefault
        Nothing
        Nothing



-- Line-like -------------------------------------------------------------------


{-| Type alias for marks with interpolation and missing value behaviour.
-}
type alias LineLike a =
    { a | interpolate : Interpolate, behaviour : Behaviour }


{-| Set the interpolation method.
-}
interpolate : Interpolate -> LineLike a -> LineLike a
interpolate method mark =
    { mark | interpolate = method }


{-| Set the `Behaviour` for missing values.
-}
behaviour : Behaviour -> LineLike a -> LineLike a
behaviour behaviour mark =
    { mark | behaviour = behaviour }



-- Path ------------------------------------------------------------------------


{-| Arbitrary paths or polygons, defined using SVG path syntax.
-}
type alias Path =
    { path : SubPath
    , x : Float
    , y : Float
    , fill : Fill
    , stroke : Stroke
    , cursor : Cursor
    , href : Maybe String
    , tooltip : Maybe String
    }


{-| Create a `Path` mark from x position, y position and SVG path definition.
-}
path : Float -> Float -> SubPath -> Path
path x y path =
    Path
        path
        x
        y
        Fill.empty
        Stroke.empty
        CursorDefault
        Nothing
        Nothing



-- Polygon ---------------------------------------------------------------------


{-| Arbitrary filled polygons defined by x and y positions and an interpolation
    method.
-}
type alias Polygon =
    { x : List (Maybe Float)
    , y : List (Maybe Float)
    , interpolate : Interpolate
    , behaviour : Behaviour
    , fill : Fill
    , stroke : Stroke
    , cursor : Cursor
    , href : Maybe String
    , tooltip : Maybe String
    }


{-| Create a polygon mark from x positions, y positions, interpolation method
    and missing value behaviour.
-}
polygon : List Float -> List Float -> Interpolate -> Behaviour -> Polygon
polygon xs ys interpolate behaviour =
    Polygon
        (List.map Just xs)
        (List.map Just ys)
        interpolate
        behaviour
        Fill.empty
        Stroke.empty
        CursorDefault
        Nothing
        Nothing



-- Rect ------------------------------------------------------------------------


{-| Rectangles.
-}
type alias Rect =
    { cornerRadius : Float
    , x : Position
    , y : Position
    , fill : Fill
    , stroke : Stroke
    , cursor : Cursor
    , href : Maybe String
    , tooltip : Maybe String
    }


{-| Create a `Rect` mark from primary x position, secondary x position,
    primary y position and secondary x position.
-}
rect : Float -> Float -> Float -> Float -> Rect
rect x x2 y y2 =
    Rect 0
        (PrimarySecondary x x2)
        (PrimarySecondary y y2)
        Fill.empty
        Stroke.empty
        CursorDefault
        Nothing
        Nothing


{-| Create a `Rect` mark from primary x position, width,
    primary y position and height.
-}
rectWidthHeight : Float -> Float -> Float -> Float -> Rect
rectWidthHeight x width y height =
    Rect 0
        (PrimaryExtent x width)
        (PrimaryExtent y height)
        Fill.empty
        Stroke.empty
        CursorDefault
        Nothing
        Nothing



-- Rule ------------------------------------------------------------------------


{-| Line segments.
-}
type alias Rule =
    { x : Position
    , y : Position
    , stroke : Stroke
    , cursor : Cursor
    , href : Maybe String
    , tooltip : Maybe String
    }


{-| Create a `Rule` mark rom primary x position, secondary x position,
    primary y position and secondary x position.
-}
rule : Float -> Float -> Float -> Float -> Rule
rule x x2 y y2 =
    Rule
        (PrimarySecondary x x2)
        (PrimarySecondary y y2)
        Stroke.empty
        CursorDefault
        Nothing
        Nothing



-- Symbol ----------------------------------------------------------------------


{-| Plotting symbols, including circles, squares and other shapes.
-}
type alias Symbol =
    { shape : Shape
    , size : Float
    , angle : Float
    , x : Float
    , y : Float
    , fill : Fill
    , stroke : Stroke
    , cursor : Cursor
    , href : Maybe String
    , tooltip : Maybe String
    }


{-| Create a `Symbol` mark from x position, y position, size and `Shape`.
-}
symbol : Float -> Float -> Float -> Shape -> Symbol
symbol x y size shape =
    Symbol
        shape
        size
        0
        x
        y
        Fill.empty
        Stroke.empty
        CursorDefault
        Nothing
        Nothing


{-| Set the `Shape` of the `Symbol` mark.
-}
shape : Shape -> Symbol -> Symbol
shape shape symbol =
    { symbol | shape = shape }


{-| Set the size of the `Symbol` mark.
-}
size : Float -> Symbol -> Symbol
size size symbol =
    { symbol | size = size }



-- Text ------------------------------------------------------------------------


{-| Text labels with configurable fonts, alignment and angle.
-}
type alias Text =
    { text : String
    , align : Align
    , baseline : Baseline
    , direction : Direction
    , dx : Float
    , dy : Float
    , elipsis : Maybe String
    , font : Font
    , angle : Float
    , radius : Float
    , theta : Float
    , x : Float
    , y : Float
    , fill : Fill
    , stroke : Stroke
    , cursor : Cursor
    , href : Maybe String
    , tooltip : Maybe String
    }


{-| Horizontal alignment.
-}
type Align
    = Left
    | Center
    | Right


{-| Vertical alignment.
-}
type Baseline
    = Top
    | Middle
    | Bottom
    | Alphabetic


{-| Flow direction.
-}
type Direction
    = LeftToRight
    | RightToLeft


{-| Create a `Text` mark from x position, y position and the text to display.
-}
text : Float -> Float -> String -> Text
text x y text =
    Text text
        Center
        Middle
        LeftToRight
        0
        0
        Nothing
        Font.default
        0
        0
        0
        x
        y
        Fill.empty
        Stroke.empty
        CursorDefault
        Nothing
        Nothing


{-| Set the relative x and y position of a `Text` mark in `em` units.
-}
relativePosition : Float -> Float -> Text -> Text
relativePosition dx dy text =
    { text | dx = dx, dy = dy }


{-| Set the horizontal alignment of a `Text` mark.
-}
align : Align -> Text -> Text
align align text =
    { text | align = align }


{-| Set the vertical alignment of a `Text` mark.
-}
baseline : Baseline -> Text -> Text
baseline baseline text =
    { text | baseline = baseline }


{-| Set the flow direction of a `Text` mark.
-}
direction : Direction -> Text -> Text
direction direction text =
    { text | direction = direction }


{-| Set the `Font` style of a `Text` mark.
-}
font : Font -> Text -> Text
font font text =
    { text | font = font }


{-| Set the font name of a `Text` mark.
-}
fontName : String -> Text -> Text
fontName name mark =
    let
        currentFont =
            mark.font

        newFont =
            { currentFont | font = name }
    in
        font newFont mark


{-| Set the font size of a `Text` mark.
-}
fontSize : Float -> Text -> Text
fontSize size mark =
    let
        currentFont =
            mark.font

        newFont =
            { currentFont | fontSize = size }
    in
        font newFont mark


{-| Set the `FontWeight` of a `Text` mark.
-}
fontWeight : Font.FontWeight -> Text -> Text
fontWeight weight mark =
    let
        currentFont =
            mark.font

        newFont =
            { currentFont | fontWeight = weight }
    in
        font newFont mark


{-| Set the `FontWeight` of a `Text` mark to *bold*.
-}
fontWeightBold : Text -> Text
fontWeightBold =
    fontWeight Font.WeightBold


{-| Set the `FontWeight` of a `Text` mark to normal.
-}
fontWeightNormal : Text -> Text
fontWeightNormal =
    fontWeight Font.WeightNormal


{-| Set the `FontStyle` of a `Text` mark.
-}
fontStyle : Font.FontStyle -> Text -> Text
fontStyle style mark =
    let
        currentFont =
            mark.font

        newFont =
            { currentFont | fontStyle = style }
    in
        font newFont mark


{-| Set the `FontStyle` of a `Text` mark to _italic_.
-}
fontStyleItalic : Text -> Text
fontStyleItalic =
    fontStyle Font.StyleItalic


{-| Set the `FontStyle` of a `Text` mark to normal.
-}
fontStyleNormal : Text -> Text
fontStyleNormal =
    fontStyle Font.StyleNormal



-- Trail -----------------------------------------------------------------------


{-| Filled lines with varying width.
-}
type alias Trail =
    { x : List (Maybe Float)
    , y : List (Maybe Float)
    , width : List (Maybe Float)
    , behaviour : Behaviour
    , fill : Fill
    , cursor : Cursor
    , href : Maybe String
    , tooltip : Maybe String
    }


{-| Create a `Trail` mark from x positions, y positions and widths.
-}
trail : List Float -> List Float -> List Float -> Behaviour -> Trail
trail xs ys widths behaviour =
    Trail
        (List.map Just xs)
        (List.map Just ys)
        (List.map Just widths)
        behaviour
        Fill.empty
        CursorDefault
        Nothing
        Nothing



-- Fill ------------------------------------------------------------------------


{-| A mark which can be filled.
-}
type alias FilledMark a =
    { a | fill : Fill }


{-| Set the `Fill` style of the mark.
-}
fill : Fill -> FilledMark a -> FilledMark a
fill fill mark =
    { mark | fill = fill }


{-| Set the fill color of the mark.
-}
fillColor : Color -> FilledMark a -> FilledMark a
fillColor color mark =
    let
        currentFill =
            mark.fill

        newFill =
            { currentFill | fill = Just color }
    in
        fill newFill mark


{-| Set the fill opacity of the mark.
-}
fillOpacity : Float -> FilledMark a -> FilledMark a
fillOpacity opacity mark =
    let
        currentFill =
            mark.fill

        newFill =
            { currentFill | fillOpacity = Just opacity }
    in
        fill newFill mark



-- Stroke  ---------------------------------------------------------------------


{-| A mark which can be stroked.
-}
type alias StrokedMark a =
    { a | stroke : Stroke }


{-| Set the `Stroke` style of the mark.
-}
stroke : Stroke -> StrokedMark a -> StrokedMark a
stroke stroke mark =
    { mark | stroke = stroke }


{-| Set the stroke color of the mark.
-}
strokeColor : Color -> StrokedMark a -> StrokedMark a
strokeColor color mark =
    let
        currentStroke =
            mark.stroke

        newStroke =
            { currentStroke | stroke = Just color }
    in
        stroke newStroke mark


{-| Set the stroke width of the mark.
-}
strokeWidth : Float -> StrokedMark a -> StrokedMark a
strokeWidth width mark =
    let
        currentStroke =
            mark.stroke

        newStroke =
            { currentStroke | strokeWidth = Just width }
    in
        stroke newStroke mark


{-| Set the stroke opacity of the mark.
-}
strokeOpacity : Float -> StrokedMark a -> StrokedMark a
strokeOpacity opacity mark =
    let
        currentStroke =
            mark.stroke

        newStroke =
            { currentStroke | strokeOpacity = Just opacity }
    in
        stroke newStroke mark


{-| Set the `StrokeDash` of the mark.
-}
strokeDash : StrokeDash -> StrokedMark a -> StrokedMark a
strokeDash dash mark =
    let
        currentStroke =
            mark.stroke

        newStroke =
            { currentStroke | strokeDash = Just dash }
    in
        stroke newStroke mark


{-| Set the `StrokeLineCap` of the mark.
-}
strokeLineCap : Stroke.StrokeLineCap -> StrokedMark a -> StrokedMark a
strokeLineCap cap mark =
    let
        currentStroke =
            mark.stroke

        newStroke =
            { currentStroke | strokeLineCap = Just cap }
    in
        stroke newStroke mark


{-| Set the `StrokeLineCap` of the mark to `CapButt`.
-}
strokeLineCapButt : StrokedMark a -> StrokedMark a
strokeLineCapButt =
    strokeLineCap Stroke.CapButt


{-| Set the `StrokeLineCap` of the mark to `CapRound`.
-}
strokeLineCapRound : StrokedMark a -> StrokedMark a
strokeLineCapRound =
    strokeLineCap Stroke.CapRound


{-| Set the `StrokeLineCap` of the mark to `CapSquare`.
-}
strokeLineCapSquare : StrokedMark a -> StrokedMark a
strokeLineCapSquare =
    strokeLineCap Stroke.CapSquare


{-| Set the `StrokeLineJoin` of the mark.
-}
strokeLineJoin : Stroke.StrokeLineJoin -> StrokedMark a -> StrokedMark a
strokeLineJoin join mark =
    let
        currentStroke =
            mark.stroke

        newStroke =
            { currentStroke | strokeLineJoin = Just join }
    in
        stroke newStroke mark


{-| Set the `StrokeLineJoin` of the mark to `JoinMiter`
    providing the  miter limit as an arugment.
-}
strokeLineJoinMiter : Float -> StrokedMark a -> StrokedMark a
strokeLineJoinMiter miterLimit =
    strokeLineJoin <| Stroke.JoinMiter miterLimit


{-| Set the `StrokeLineJoin` of the mark to `JoinRound`
-}
strokeLineJoinRound : StrokedMark a -> StrokedMark a
strokeLineJoinRound =
    strokeLineJoin Stroke.JoinRound


{-| Set the `StrokeLineJoin` of the mark to `JoinBevel`
-}
strokeLineJoinBevel : StrokedMark a -> StrokedMark a
strokeLineJoinBevel =
    strokeLineJoin Stroke.JoinBevel



-- Miscellaneous ---------------------------------------------------------------


{-| Set the angle of rotation (in degrees) of a mark.
-}
angle : Float -> { c | angle : Float } -> { c | angle : Float }
angle angle mark =
    { mark | angle = angle }


{-| Set the corner radius of a mark.
-}
cornerRadius : Float -> { c | cornerRadius : Float } -> { c | cornerRadius : Float }
cornerRadius radius mark =
    { mark | cornerRadius = radius }



-- Common ----------------------------------------------------------------------


{-| Properties supported by all marks.
-}
type alias Mark a =
    { a | href : Maybe String, tooltip : Maybe String }


{-| Set URL to open when a mark is clicked.
-}
href : String -> Mark a -> Mark a
href href mark =
    { mark | href = Just href }


{-| Set the text to display when a mark is hovered over.
-}
tooltip : String -> Mark a -> Mark a
tooltip text mark =
    { mark | tooltip = Just text }
