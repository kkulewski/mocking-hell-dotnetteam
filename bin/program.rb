require_relative '../lib/host_app'

app = HostApp.new(ConsoleIo.new)
app.populate_users
app.populate_books
app.run
