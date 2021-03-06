module Login exposing (..)

{-| The login page.
-}

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Encode as Encode
import Validate exposing (Validator, ifBlank, validate)
-- import Window


-- MAIN


main : Program Parameters Model Msg
main =
    Html.programWithFlags
        { init = initialModel
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }

type alias Parameters =
    { action : String }


-- MODEL --


type alias Model =
    { errors : List Error
    , email : String
    , password : String
    , response : Maybe String
    , parameters : Parameters
    }


initialModel : Parameters -> ( Model, Cmd Msg )
initialModel parameters = (
    { errors = []
    , email = ""
    , password = ""
    , response = Nothing
    , parameters = parameters
    }
    , Cmd.none )
--        ! [ Task.perform Resized Window.size
--          ]


type alias Error =
    ( FormField, String )


type Msg
    = NoOp
    | SubmitForm
    | SetEmail String
    | SetPassword String
    | Response (Result Http.Error String)


type FormField
    = Email
    | Password


-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case Debug.log "msg" msg of
        NoOp ->
            ( model, Cmd.none )

        SubmitForm ->
            case validate modelValidator model of
                [] -> ( model, Cmd.none )
{--
                    ( { model | errors = [], response = Nothing }
                    , Http.send Response (postRequest model)
                    )
--}

                errors ->
                    ( { model | errors = errors }
                    , Cmd.none
                    )

        SetEmail email ->
            ( { model | email = email }, Cmd.none )

        SetPassword password ->
            ( { model | password = password }, Cmd.none )

        Response (Ok response) ->
            ( { model | response = Just response }, Cmd.none )

        Response (Err error) ->
            ( { model | response = Just (toString error ++ " - See the Console for more details.") }, Cmd.none )


--HELPERS


postRequest : Model -> Http.Request String
postRequest model =
    let
        body =
            Encode.object
                [ ( "email", Encode.string model.email )
                , ( "password", Encode.string model.password )
                ]
                |> Http.jsonBody
    in
    Http.request
        { method = "POST"
        , headers = []
        , url = "http://localhost:53001/"
        , body = body
        , expect = Http.expectString
        , timeout = Nothing
        , withCredentials = False
        }


modelValidator : Validator Error Model
modelValidator =
    Validate.all
        [ ifBlank .email (Email => "email can't be blank.")
        , ifBlank .password (Password => "password can't be blank.")
        ]

(=>) : a -> b -> ( a, b )
(=>) =
    (,)


-- VIEWS


view : Model -> Html Msg
view model =
    div []
        [ viewSimple "v01" (viewForm model) ]


viewFooter : String -> Html msg
viewFooter version =
    div [ class "footer" ]
        [ a [ href "https://google.co.in" ] [ text "[ google ] " ]
        , a [ href "https://github.com/AppayRocks/Yesod_Elm_App" ] [ text " [ article ]" ]
        ]

viewHeader : String -> Html msg
viewHeader version =
    div [ class "header" ]
        [ h1 [] [ text ("Elm Login Form: " ++ version) ]
        , p [] [ text <| "Examples of Form built in elm" ]
        ]


viewSimple : String -> Html msg -> Html msg
viewSimple exampleVersion viewForm =
    div []
        [ viewHeader exampleVersion
        , viewForm
        , viewFooter exampleVersion
        ]


viewForm : Model -> Html Msg
viewForm model =
    Html.form
        [ method "post"
        , action model.parameters.action
        , class "form-container"
--        , onSubmit SubmitForm
        ]
        [ label []
            [ text "Email"
            , input
                [ type_ "text"
                , name "username"
                , placeholder "Email"
                , onInput SetEmail
                , value model.email
                ]
                []
            , viewFormErrors Email model.errors
            ]
        , label []
            [ text "Password"
            , input
                [ type_ "password"
                , name "password"
                , placeholder "Password"
                , onInput SetPassword
                , value model.password
                ]
                []
            , viewFormErrors Password model.errors
            ]
        , input
            [ type_ "submit"
            , value "Login"
            , id "login_button"
--            , onSubmit SubmitForm
            ]
            []

{--        , button
            []
            [ text "Submit" ]
--}
        ]


viewFormErrors : FormField -> List Error -> Html msg
viewFormErrors field errors =
    errors
        |> List.filter (\( fieldError, _ ) -> fieldError == field)
        |> List.map (\( _, error ) -> li [] [ text error ])
        |> ul [ class "formErrors" ]
