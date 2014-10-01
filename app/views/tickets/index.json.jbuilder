json.array!(@tickets) do |ticket|
  json.extract! ticket, :id, :event_name, :datetime, :place, :price, :twitter_token
  json.url ticket_url(ticket, format: :json)
end
