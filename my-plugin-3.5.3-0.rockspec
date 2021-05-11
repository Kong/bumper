package = "my-bumper"
version = "3.5.3-0"

source = {
  url = "https://github.com/jeremymv2/bumper",
  tag = "3.5.3"
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
