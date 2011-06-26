# usage: log('inside coolFunc', this, arguments);
# paulirish.com/2009/log-a-lightweight-wrapper-for-consolelog/
window.log = ->
  log.history = log.history or []
  log.history.push arguments
  if @console
    arguments.callee = arguments.callee.caller
    console.log Array::slice.call(arguments)

# make it safe to use console.log always
((b) ->
  c = ->
  d = "assert,count,debug,dir,dirxml,error,exception,group,groupCollapsed,groupEnd,info,log,markTimeline,profile,profileEnd,time,timeEnd,trace,warn".split(",")

  while a = d.pop()
    b[a] = b[a] or c
) window.console = window.console or {}

# place any jQuery/helper plugins in here, instead of separate, slower script files.

