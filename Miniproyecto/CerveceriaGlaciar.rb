dir = "/path/to/directory"
$LOAD_PATH.unshift(dir)
Dir["/path/to/directory/*.rb"].each {|file| load file }
