defmodule Blog.Post do
	use Blog.Web, :model
	import Ecto.Query



	schema "posts" do
		field :title, :string 
		field :content, :string

		timestamps
	end

	def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :content])
    |> validate_required([:title, :content])
  end

end