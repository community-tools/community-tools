defmodule CommunityToolsWeb.Redirects do
  use Plug.Redirect

  # Argument #1 is the path to redirect from
  # Argument #2 is the path to redirect to

  #redirect "/", "/2017"

  redirect "/cfp", "/2017/cfp"

  redirect "/dashboard", "/2017/dashboard"

  redirect "/profile", "/2017/profile"



  # An HTTP status code can also be specified
  #redirect "/grace", "/hopper", status: 302

  # Segements prefixed with a colon will match anything
  #redirect "/blog/:anything", "/blog-closed"

  # Variable segments can be interpolated into the destination
  #redirect "/users/:name", "/profile/:name"
end
