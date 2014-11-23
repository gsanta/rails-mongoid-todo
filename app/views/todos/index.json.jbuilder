json.array!(@todos) do |todo|
  json.extract! todo, :id, :title, :important, :done
  json.url todo_url(todo, format: :json)
end
