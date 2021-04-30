package = "my-bumper"
version = "3.1.2-0"

source = {
  url = "https://github.com/jeremymv2/bumper",
  tag = "3.1.2"
}

supported_platforms = {"linux", "macosx"}
description = {
  summary = "Beep Boop",
}

build = {
  type = "builtin",
  modules = {
    ["my.bumper.yay.handler"] = "my/plugins/yay/handler.lua",
  }
}