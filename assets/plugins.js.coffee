# usage: log('inside coolFunc', this, arguments);
# paulirish.com/2009/log-a-lightweight-wrapper-for-consolelog/
window.log = () ->
  log.history = log.history or []
  log.history.push(arguments)
  if @console
    arguments.callee = arguments.callee.caller
    console.log(Array.prototype.slice.call(arguments))

# make it safe to use console.log always
class Console
  constructor: () ->
  log: () ->
    window.log arguments

window.console = window.console || new Console()

# place any jQuery/helper plugins in here, instead of separate, slower script files.

