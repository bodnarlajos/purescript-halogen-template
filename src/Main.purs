module Main where

import Prelude

import Effect (Effect)
import Halogen as H
import Halogen.Aff as HA
import Halogen.HTML as HH
import Halogen.HTML.Events as HE
import Halogen.HTML.Properties as HP
import Halogen.VDom.Driver (runUI)

main :: Effect Unit
main = HA.runHalogenAff do
  body <- HA.awaitBody
  runUI component unit body

data Action = Increment | Decrement

component =
  H.mkComponent
    { initialState
    , render
    , eval: H.mkEval $ H.defaultEval { handleAction = handleAction }
    }
  where
  initialState _ = 0

  render state =
    HH.div_ 
    [
      HH.div_
        [ HH.button [ HE.onClick \_ -> Decrement ] [ HH.text "-" ]
        , HH.div_ [ HH.text $ show state ]
        , HH.button [ HE.onClick \_ -> Increment ] [ HH.text "+" ]
        ],
      HH.div_
        [
          HH.a [HP.href "https://dev-nzejyvbqg0u7eexk.us.auth0.com/authorize?client_id=OjOBpyoKKsf0KkQZlXuAj8T6BnDIvrcY&scope=openid profile email&redirect_uri=http://localhost:8080/auth&prompt=login&response_type=token&response_mode=query&state=X1hCdkZ2amQ4MloyeUo5SUtuOENfZnNtbk9lbWxTUk5SLjQzbmdtLlZKVA==&nonce=TWM4WXFRZkhmVUxsS09Ham5rVVdDR21LV1M4VElKRWpvUHk5NlZpOEk2WA==&code_challenge=Uue4q3mMGtl9BP_bw9G1Q7NEFhSd6UiEXcuG5ZYozOI&code_challenge_method=S256&auth0Client=eyJuYW1lIjoiYXV0aDAtcmVhY3QiLCJ2ZXJzaW9uIjoiMi4wLjAifQ=="] [HH.text "login2"]
        ]
    ]

  handleAction = case _ of
    Increment -> H.modify_ \state -> state + 1
    Decrement -> H.modify_ \state -> state - 1