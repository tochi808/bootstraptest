
#
# * GET home page.
# 
exports.index = (req, res) ->
  res.render "index",
    title: "Express"

exports.new = (req, res) ->
  res.render "new",
    title: "new"

