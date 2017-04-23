module MainWithAmount exposing (..)

import Html exposing (Html, div, text)
import Html.Attributes exposing (style)


main : Html a
main =
    div [ style styleWrapper ]
        [ text "Total cart:"
        , div [] [ text <| viewAmount <| getTotalCart cartWithItems ]
        ]


type Amount
    = Amount Int


type alias Item =
    { name : String
    , amount : Amount
    , id : Int
    }


shirt : Item
shirt =
    { name = "Shirt"
    , amount = Amount 10
    , id = 1
    }


pants : Item
pants =
    { name = "Pants"
    , amount = Amount 20
    , id = 2
    }


type alias AddedItem =
    { item : Item
    , quantity : Int
    }


addedShirt : AddedItem
addedShirt =
    AddedItem shirt 1


addedPants : AddedItem
addedPants =
    AddedItem pants 1


type alias Cart =
    { addedItems : List AddedItem
    }


emptyCart : Cart
emptyCart =
    { addedItems = []
    }


cartWithItems : Cart
cartWithItems =
    { addedItems =
        [ addedShirt
        , addedPants
        ]
    }



-- getAmount : Item -> Int
-- getAmount item =
--     item.amount


getAmount : Item -> Amount
getAmount =
    .amount


appendAmount : Amount -> Amount -> Amount
appendAmount (Amount first) (Amount second) =
    Amount (first + second)


viewAmount : Amount -> String
viewAmount (Amount x) =
    "$" ++ toString x


getTotalCart : Cart -> Amount
getTotalCart cart =
    List.foldl
        (\addedItem accum ->
            getAmount addedItem.item
                |> appendAmount accum
        )
        (Amount 0)
        cart.addedItems


styleWrapper : List ( String, String )
styleWrapper =
    [ ( "display", "flex" )
    , ( "align-items", "center" )
    , ( "justify-content", "center" )
    , ( "margin-top", "100px" )
    ]
