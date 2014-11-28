Rails.application.routes.draw do

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root(controller: "tickets", action: "index")

  get("/callback", controller: "session", action: "callback")
  post("/callback", controller: "session", action: "callback")
  get("/logout", controller: "session", action: "destroy",as: :logout)
  get("/auth/failure", controller: "session", action: "failure")
  
  get("/mytickets", controller: "user", action: "myticket")
  get("/tag_watch", controller: "user", action: "watch_tag")
  put("/update", controller: "user", action: "update")

  get("/tickets_bot/:id", controller: "tickets_bot", action: "show")

  post("/tweet/reply", controller: "tweet", action: "reply")

  resources(:tickets) do
    member do
    end
    
    collection do
      get("search")
    end
  end
  
  get("*path", controller: "application", action: "render_404")

end
