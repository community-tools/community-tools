defmodule CommunityTools.SlugsProfiles do
  #use EctoAutoslugField.Slug, from: (:name_first, :name_last), to: :slug, always_change: true

  use EctoAutoslugField.Slug, to: :slug, always_change: true

  import Ecto.Changeset

  def get_sources(changeset, _opts) do
    # This function is used to get sources to build slug from:
    base_fields = [:name_first, :name_last]

    base_fields

  end

#  def build_slug(sources, _changeset) do
#    sources
#    |> super()
#    |> String.replace("-", "+")
#  end

end
