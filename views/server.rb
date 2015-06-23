require("sinatra")
require("sinatra/reloader") if development?
require ("pry")

get("/") {erb(:home)}
get("/home") {erb(:home)}
post("/home"){erb(:home_post)}

