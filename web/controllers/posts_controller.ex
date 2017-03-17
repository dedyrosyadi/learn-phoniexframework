defmodule Blog.PostsController do
	use Blog.Web, :controller


	def index(conn, _params) do

		
		posts = Blog.Repo.all(Blog.Post, order_by: "inserted_at")
		render conn, "index.html", posts: posts
	end

	def new(conn, _params) do
		post = %Blog.Post{title: "", content: ""}
		render conn, "new.html", post: post
	end


	def create(conn, params) do
		post = %Blog.Post{
			title: params["post"]["title"], 
			content: params["post"]["content"]
		}

		Blog.Repo.insert!(post)
		redirect conn, to: "/posts"
	end

  # def edit(conn, %{ "id" => id }) do
  #   post = Blog.Post |> Blog.Repo.get(id)
  #   render conn, "edit.html", post: post
  # end

  def edit(conn, %{"id" => id}) do
    post = Repo.get!(Blog.Post, id)
    # post = Blog.Post |> Blog.Repo.get(id)
    changeset = Blog.Post.changeset(post)
    render(conn, "edit.html", post: post, changeset: changeset)
  end


	def show(conn, %{ "id" => id }) do
    post = Blog.Post |> Blog.Repo.get(id)
    render conn, "show.html", post: post
  end


  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Repo.get!(Blog.Post, id)
    changeset = Blog.Post.changeset(post, post_params)

    case Repo.update(changeset) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post updated successfully.")
        |> redirect(to: post_path(conn, :show, post))
      {:error, changeset} ->
        render(conn, "edit.html", post: post, changeset: changeset)
    end
  end

  def delete(conn, %{ "id" => id }) do
    post = Blog.Post
    |> Blog.Repo.get(id)
    |> Blog.Repo.delete!

    # conn |> redirect(to: post_path(conn, :index))
    redirect conn, to: "/posts"

  end

end