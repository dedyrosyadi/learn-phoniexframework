defmodule Blog.Router do
  use Blog.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Blog do
    pipe_through :browser # Use the default browser stack

    get "/",                PageController,   :index
    get "/posts",           PostsController,  :index
    get "/posts/new",       PostsController,  :new
    post "/posts",          PostsController,  :create
    get "/posts/:id",       PostsController,  :show, as: :post
    get "/posts/:id/edit",  PostsController,  :edit, as: :post
    put "/posts/:id",       PostsController,  :update, as: :post
    delete "/posts/:id",    PostsController,  :delete, as: :post

  end

  # Other scopes may use custom stacks.
  # scope "/api", Blog do
  #   pipe_through :api
  # end
end
