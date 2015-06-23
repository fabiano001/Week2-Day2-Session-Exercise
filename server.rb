require("sinatra")
require("sinatra/reloader") if development?
require ("pry")

enable(:sessions)

users = {
	"Fabiano" 	=> ["passwordfab", "pizza", "I'm a coder from Brazil"],
	"Cesar" 	=> ["passwordces", "spaguetti", "I'm a coder from France"],
	"Luis" 		=> ["passwordlui", "grilled chicken", "I'm a coder from Miami"],
	"Eddie" 	=> ["passwordedd", "nachos", "I'm a coder from USA"],
	"Guillermo" => ["passwordgui", "sushi", "I'm a coder from Miami"]
}

get("/") {erb(:login)}
get("/login") {erb(:login)}

post("/login"){

	username = params[:user_name]
	password = params[:user_pw]
	pass_hash = users[username]
	@authenticated = false

	if (users[username] != nil && users[username][0] == password)
		@authenticated = true
		session[:username] = username
		redirect to("/profile")
	else
		erb(:login)
	end
}

get("/session"){
	if(session[:username]!=nil)
		return "Currently in the session: #{session[:username]}"
	else
		return "No current session available on this machine."
	end
}

get("/profile") {
	@username = session[:username]

	if(@username != nil)
		@food = users[@username][1]
		@bio = users[@username][2]
		erb(:profile)
	else
		redirect(to("/login"))
	end
}

get("/logout"){
  session.clear
  erb(:login)
}


# get("/session/:value"){
# 	session[:value] =  params[:value]
# 	"Saved in the session: #{session[:value]}."
# }

