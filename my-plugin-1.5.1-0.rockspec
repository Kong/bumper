package = "my-bumper"
version = "1.5.1-0"

source = {
  url = "https://github.com/jeremymv2/bumper",
  tag = "1.5.1"
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