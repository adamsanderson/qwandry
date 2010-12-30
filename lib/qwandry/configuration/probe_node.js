// If anyone knows a way to pipe a one liner into node to do this, 
// I'm all ears.
var sys = require('sys')
sys.puts(require.paths.join("\n"))