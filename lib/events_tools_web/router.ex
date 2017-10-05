defmodule CommunityToolsWeb.Router do
  use CommunityToolsWeb, :router

  import Plug.Conn
  alias CommunityToolsWeb.HostParser



  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    #plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :browser_session do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
  end

  pipeline :require_login do
    plug Guardian.Plug.EnsureAuthenticated, handler: CommunityTools.GuardianErrorHandler
  end

  pipeline :parse_host do
     #HostParser.host_parse("test.nodecamp.io")
  end


  scope "/", CommunityToolsWeb do
  #scope "/", host: "local.opencamps.org" do
    #pipe_through :browser # Use the default browser stack
    pipe_through [:browser, :parse_host, :browser_session] # Use the default browser stack

    scope host: "local.apps.camp" do
      get "/", EventController, :apps
    end

    scope host: "test.nodecamp.io" do
      get "/", EventController, node
      get "/profiles/:id", ProfileController, :show
      get "/presentations/:id", PresentationController, :show
    end

    scope host: "test.angular.camp" do
      get "/", EventController, :angular
      get "/profiles/:id", ProfileController, :show
      get "/presentations/:id", PresentationController, :show
    end

    scope host: "test.arvr.camp" do
      get "/", EventController, :arvr
      get "/profiles/:id", ProfileController, :show
      get "/presentations/:id", PresentationController, :show
    end

    scope host: "dev.arvr.camp" do
      get "/", EventController, :arvr
      get "/profiles/:id", ProfileController, :show
      get "/presentations/:id", PresentationController, :show
    end

    scope host: "local.arvr.camp" do
      get "/", EventController, :arvr
      get "/profiles/:id", ProfileController, :show
      get "/presentations/:id", PresentationController, :show
    end

    scope host: "dev.angular.camp" do
      get "/", EventController, :angular
      get "/profiles/:id", ProfileController, :show
      get "/presentations/:id", PresentationController, :show
    end

    scope host: "local.arvr.camp" do
      get "/", EventController, :arvr
      get "/profiles/:id", ProfileController, :show
      get "/presentations/:id", PresentationController, :show
    end

    scope host: "test.biotech.camp" do
      get "/", EventController, :biotech
      get "/profiles/:id", ProfileController, :show
      get "/presentations/:id", PresentationController, :show
    end

    scope host: "dev.biotech.camp" do
      get "/", EventController, :biotech
      get "/profiles/:id", ProfileController, :show
      get "/presentations/:id", PresentationController, :show
    end

    scope host: "local.biotech.camp" do
      get "/", EventController, :biotech
      get "/profiles/:id", ProfileController, :show
      get "/presentations/:id", PresentationController, :show
    end

    scope host: "local.community.camp" do
      get "/", EventController, :dataviz
      get "/profiles/:id", ProfileController, :show
      get "/presentations/:id", PresentationController, :show
    end

    scope host: "local.dataviz.io" do
      get "/", EventController, :dataviz
      get "/profiles/:id", ProfileController, :show
      get "/presentations/:id", PresentationController, :show
    end

    scope host: "test.designcamp.io" do
      get "/", EventController, :design
      get "/profiles/:id", ProfileController, :show
      get "/presentations/:id", PresentationController, :show
    end

    scope host: "dev.designcamp.io" do
      get "/", EventController, :design
      get "/profiles/:id", ProfileController, :show
      get "/presentations/:id", PresentationController, :show
    end

    scope host: "local.designcamp.io" do
      get "/", EventController, :design
      get "/profiles/:id", ProfileController, :show
      get "/presentations/:id", PresentationController, :show
    end

    scope host: "dev.elixircamp.io" do
      get "/", EventController, :elixir
      get "/profiles/:id", ProfileController, :show
      get "/presentations/:id", PresentationController, :show
    end

    scope host: "test.gocamp.io" do
      get "/", EventController, :go
      get "/profiles/:id", ProfileController, :show
      get "/presentations/:id", PresentationController, :show
    end

    scope host: "dev.gocamp.io" do
      get "/", EventController, :go
      get "/profiles/:id", ProfileController, :show
      get "/presentations/:id", PresentationController, :show
    end

    scope host: "local.gocamp.io" do
      get "/", EventController, :go
      get "/profiles/:id", ProfileController, :show
      get "/presentations/:id", PresentationController, :show
    end

    scope host: "test.nextgen.camp" do
      get "/", EventController, :nextgen
      get "/profiles/:id", ProfileController, :show
      get "/presentations/:id", PresentationController, :show
    end

    scope host: "dev.nextgen.camp" do
      get "/", EventController, :nextgen
      get "/profiles/:id", ProfileController, :show
      get "/presentations/:id", PresentationController, :show
    end

    scope host: "dev.nodecamp.io" do
      get "/", EventController, :node
      get "/profiles/:id", ProfileController, :show
      get "/presentations/:id", PresentationController, :show
    end

    scope host: "local.nodecamp.io" do
      get "/", EventController, :node
      get "/profiles/:id", ProfileController, :show
      get "/presentations/:id", PresentationController, :show
    end

    scope host: "local.nodecamp.io" do
      get "/", EventController, :node
      get "/profiles/:id", ProfileController, :show
      get "/presentations/:id", PresentationController, :show
    end

    scope host: "dev.phoenix.camp" do
      get "/", EventController, :phoenix
    end

    scope host: "dev.reactcamp.io" do
      get "/", EventController, :react
    end

    scope host: "dev.womeninopensource.camp" do
      get "/", EventController, :women
    end

    scope host: "opencamps.org" do
      pipe_through [:browser, :browser_session]

      get "/sign-out", AccountsController, :signout
      post "/sign-out", AccountsController, :signout
      get "/credentials", AccountsController, :credentials
      get "/signup", SignupController, :new

      scope "/sign-in" do

        #pipe_through [:browser] # Use the default browser stack

        get "/", AccountsController, :signin
        post "/", AccountsController, :signout

        get "/:identity", AccountsController, :signin
        get "/:identity", AccountsController, :signin
        get "/:identity/callback", AccountsController, :callback
        post "/:identity/callback", AccountsController, :callback

      end


      scope "/2017" do
        get "/", LandingController, :homepage
        get "/about", LandingController, :about
        get "/team", ProfileController, :team
        get "/profiles/:id", ProfileController, :show
        get "/events", EventController, :index
        get "/sponsors", SponsorController, :index
        get "/location", LandingController, :location
        get "/news", PostController, :index
        get "/news/:id", PostController, :show

        get "/profile", ProfileController, :profile


        get "/presentations", PresentationController, :index
        get "/presentations/:id", PresentationController, :show
        get "/cfp", PresentationController, :cfp

        get "/sign-out", AccountsController, :signout
        post "/sign-out", AccountsController, :signout
        get "/dashboard", AccountsController, :dashboard

      end

      pipe_through [:browser, :browser_session, :require_login]

      resources "/presentations", PresentationController
      resources "/profiles", ProfileController

    end

    scope host: "www.opencamps.org" do
      pipe_through [:browser, :browser_session]

      scope "/2017" do
        get "/", LandingController, :homepage
        get "/about", LandingController, :about
        get "/team", ProfileController, :team
        get "/events", EventController, :index
        get "/sponsors", SponsorController, :index
        get "/location", LandingController, :location
        get "/news", PostController, :index
        get "/news/:id", PostController, :show
      end
    end





    scope host: "local.opencamps.org" do

      get "/sign-out", AccountsController, :signout
      post "/sign-out", AccountsController, :signout
      get "/credentials", AccountsController, :credentials
      get "/signup", SignupController, :new

      scope "/sign-in" do

        #pipe_through [:browser] # Use the default browser stack
        pipe_through [:browser, :browser_session]

        get "/", AccountsController, :signin
        post "/", AccountsController, :signout

        get "/:identity", AccountsController, :signin
        get "/:identity", AccountsController, :signin
        get "/:identity/callback", AccountsController, :callback
        post "/:identity/callback", AccountsController, :callback

      end

      scope "/2017", host: "local.opencamps.org" do
        pipe_through [:browser, :browser_session]

        get "/dashboard", AccountsController, :dashboard
        get "/location", LandingController, :location
         #get "/presentations", LandingController, :presentations
        get "/schedule", LandingController, :schedule
        get "/speakers", LandingController, :speakers
        get "/sponsorship_options", SponsorshipOptionController, :index

        resources "/events", EventController
        get "/events", EventController, :index
        get "/events/:id", EventController, :show

        get "/presentations", PresentationController, :index
        get "/presentations/:id", PresentationController, :show
        resources "/presentations", PresentationController
        get "/cfp", PresentationController, :cfp

        get "/posts", PostController, :index
        get "/posts/:id", PostController, :show

        get "/profiles", ProfileController, :index
        get "/team", ProfileController, :team

        get "/profile", ProfileController, :profile

        get "/sponsors", SponsorController, :index
        get "/sponsorship_options", SponsorshipOptionController, :index

        resources "/status", StatusController

        resources "/organizations", OrganizationController
        resources "/sponsors", SponsorController

        resources "/roles", RolesController

        resources "/users", UserController

        resources "/technologies", TechnologyController


        get "/sign-out", AccountsController, :signout
        post "/sign-out", AccountsController, :signout
        get "/credentials", AccountsController, :credentials
        get "/signup", SignupController, :new
        get "/about", LandingController, :about

      end

      pipe_through [:browser, :browser_session, :require_login]

        #   Event Routes
        #get "/events", EventController, :index
        #get "/admin/events", EventController, :admin
        #get "/admin/events/new", EventController, :new
        #post "/admin/events/create", EventController, :add
        #get "/event/:id", EventController, :show
        #get "/admin/events/:id/edit", EventController, :edit
        #put "/admin/events/:id", EventController, :update
        #delete "/admin/event/:id", EventController, :delete

        resources "/comments", CommentController

        resources "/posts", PostController
        resources "/presentations", PresentationController

        resources "/profiles", ProfileController


        resources "/tags", TagController
        resources "/venues", VenueController
        resources "/buildings", BuildingController
        resources "/halls", HallController
        resources "/hall_room_plans", Hall_Room_PlanController
        resources "/rooms", RoomController


        # Admin UI Routes
        get "/admin", AdminController, :admin

    end




   scope "/", host: "test.opencamps.org" do
     get "/", LandingController, :homepage

     get "/sign-out", AccountsController, :signout
     post "/sign-out", AccountsController, :signout
     get "/credentials", AccountsController, :credentials
     get "/signup", SignupController, :new
     get "/profile", ProfileController, :profile

     scope "/sign-in" do

       #pipe_through [:browser] # Use the default browser stack
       pipe_through [:browser, :browser_session]

       get "/", AccountsController, :signin
       post "/", AccountsController, :signout

       get "/:identity", AccountsController, :signin
       get "/:identity", AccountsController, :signin
       get "/:identity/callback", AccountsController, :callback
       post "/:identity/callback", AccountsController, :callback

     end

    scope "/2017", host: "test.opencamps.org" do
      pipe_through [:browser, :browser_session]

      get "/", LandingController, :homepage
      get "/about", LandingController, :about

      get "/dashboard", AccountsController, :dashboard


      get "/location", LandingController, :location
       #get "/presentations", LandingController, :presentations
      get "/schedule", LandingController, :schedule
      get "/speakers", LandingController, :speakers
      get "/sponsorship_options", SponsorshipOptionController, :index

      resources "/events", EventController
      get "/events", EventController, :index
      get "/events/:id", EventController, :show

      get "/presentations", PresentationController, :index
      get "/presentations/:id", PresentationController, :show
      resources "/presentations", PresentationController
      get "/cfp", PresentationController, :cfp

      get "/posts", PostController, :index
      get "/posts/:id", PostController, :show

      get "/profiles", ProfileController, :index
      get "/team", ProfileController, :team

      get "/profile", ProfileController, :profile

      get "/sponsors", SponsorController, :index
      get "/sponsorship_options", SponsorshipOptionController, :index

      resources "/status", StatusController

      resources "/organizations", OrganizationController
      resources "/sponsors", SponsorController

      resources "/roles", RolesController

      resources "/users", UserController

      get "/sign-out", AccountsController, :signout
      post "/sign-out", AccountsController, :signout
      get "/credentials", AccountsController, :credentials
      get "/signup", SignupController, :new
      get "/about", LandingController, :about
      get "/profile", ProfileController, :profile
      get "/", LandingController, :homepage

    end

    pipe_through [:browser, :browser_session, :require_login]

      #   Event Routes
      #get "/events", EventController, :index
      #get "/admin/events", EventController, :admin
      #get "/admin/events/new", EventController, :new
      #post "/admin/events/create", EventController, :add
      #get "/event/:id", EventController, :show
      #get "/admin/events/:id/edit", EventController, :edit
      #put "/admin/events/:id", EventController, :update
      #delete "/admin/event/:id", EventController, :delete

      resources "/comments", CommentController

      resources "/posts", PostController
      resources "/presentations", PresentationController

      resources "/profiles", ProfileController


      resources "/tags", TagController
      resources "/venues", VenueController
      resources "/buildings", BuildingController
      resources "/halls", HallController
      resources "/hall_room_plans", Hall_Room_PlanController
      resources "/rooms", RoomController


      # Admin UI Routes
      get "/admin", AdminController, :admin

    end




    scope "/2017", host: "dev.opencamps.org" do

      get "/", LandingController, :homepage
      get "/about", LandingController, :about
      get "/location", LandingController, :location
      #get "/presentations", LandingController, :presentations
      get "/schedule", LandingController, :schedule
      get "/speakers", LandingController, :speakers
      get "/sponsorship_options", SponsorshipOptionController, :index

      get "/events", EventController, :index
      get "/events/:id", EventController, :show

      get "/presentations", PresentationController, :index
      get "/presentations/:id", PresentationController, :show
      resources "/presentations", PresentationController

      get "/posts", PostController, :index
      get "/posts/:id", PostController, :show

      get "/profiles", ProfileController, :index
      get "/team", ProfileController, :team

      get "/profile", ProfileController, :profile

      get "/sponsors", SponsorController, :index
      get "/sponsorship_options", SponsorshipOptionController, :index

      resources "/status", StatusController

      resources "/organizations", OrganizationController
      resources "/sponsors", SponsorController

      resources "/roles", RolesController

      resources "/users", UserController


      pipe_through [:browser, :browser_session, :require_login]

       #   Event Routes
       #get "/events", EventController, :index
       #get "/admin/events", EventController, :admin
       #get "/admin/events/new", EventController, :new
       #post "/admin/events/create", EventController, :add
       #get "/event/:id", EventController, :show
       #get "/admin/events/:id/edit", EventController, :edit
       #put "/admin/events/:id", EventController, :update
       #delete "/admin/event/:id", EventController, :delete

       resources "/events", EventController
       resources "/comments", CommentController

       resources "/posts", PostController
       resources "/presentations", PresentationController

       resources "/profiles", ProfileController


       resources "/tags", TagController
       resources "/venues", VenueController
       resources "/buildings", BuildingController
       resources "/halls", HallController
       resources "/hall_room_plans", Hall_Room_PlanController
       resources "/rooms", RoomController


       # Admin UI Routes
       get "/admin", AdminController, :admin

    end

    get "/", LandingController, :homepage

    get "/sign-out", AccountsController, :signout
    post "/sign-out", AccountsController, :signout
    get "/credentials", AccountsController, :credentials
    get "/signup", SignupController, :new

    scope "/sign-in" do

      #pipe_through [:browser] # Use the default browser stack
      pipe_through [:browser, :browser_session]

      get "/", AccountsController, :signin
      post "/", AccountsController, :signout

      get "/:identity", AccountsController, :signin
      get "/:identity", AccountsController, :signin
      get "/:identity/callback", AccountsController, :callback
      post "/:identity/callback", AccountsController, :callback

    end

    scope "/2017" do
      get "/", LandingController, :homepage
      get "/about", LandingController, :about
      get "/team", ProfileController, :team
      get "/profiles/:id", ProfileController, :show
      get "/events", EventController, :index
      get "/sponsors", SponsorController, :index
      get "/location", LandingController, :location
      get "/news", PostController, :index
      get "/news/:id", PostController, :show
    end

  end


  # Other scopes may use custom stacks.
  # scope "/api", CommunityToolsWeb do
  #   pipe_through :api
  # end
end
