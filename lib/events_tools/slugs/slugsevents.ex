defmodule CommunityTools.SlugsEvents do
  use EctoAutoslugField.Slug, from: :name, to: :slug, always_change: true
end
