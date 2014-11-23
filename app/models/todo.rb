class Todo
  include Mongoid::Document
  field :title, type: String
  field :important, type: Mongoid::Boolean
  field :done, type: Mongoid::Boolean
end
