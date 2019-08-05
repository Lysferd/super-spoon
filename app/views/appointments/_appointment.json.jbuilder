json.extract! appointment, :id, :description, :host_id, :visitor_id, :created_at, :updated_at
json.url appointment_url(appointment, format: :json)
