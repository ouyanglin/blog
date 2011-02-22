Factory.define :user do |user|
  user.display_name "ExampleUser"
  user.email        "user@example.org"
end

Factory.define :post do |post|
  post.title "First Post"
  post.body "Hello World! Welcome to my frist post"
  post.association :user
end
