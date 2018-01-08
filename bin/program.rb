require_relative '../lib/app_demo'

app = AppDemo.new(ConsoleIo.new)
app.populate_users
app.populate_books
app.run
