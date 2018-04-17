module Facet.Scenegraph.Cursor exposing (Cursor(..))

{-|
@docs Cursor
-}


{-| HTML cursor variants
-}
type Cursor
    = CursorAuto
    | CursorDefault
    | CursorNone
    | CursorContextMenu
    | CursorHelp
    | CursorPointer
    | CursorProgress
    | CursorWait
    | CursorCell
    | CursorCrosshair
    | CursorText
    | CursorVerticalText
    | CursorAlias
    | CursorCopy
    | CursorMove
    | CursorNoDrop
    | CursorNotAllowed
    | CursorEResize
    | CursorNResize
    | CursorNEResize
    | CursorNWResize
    | CursorSResize
    | CursorSEResize
    | CursorSWResize
    | CursorWResize
    | CursorEWResize
    | CursorNSResize
    | CursorNESWResize
    | CursorNWSEResize
    | CursorColResize
    | CursorRowResize
    | CursorAllScroll
    | CursorZoomIn
    | CursorZoomOut
    | CursorGrab
    | CursorGrabbing
    | CursorUrl String (Maybe Int) (Maybe Int)
