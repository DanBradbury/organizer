json.array!(@site_managers) do |site_manager|
  json.extract! site_manager, :id, :name, :url, :img
  json.url site_manager_url(site_manager, format: :json)
end
