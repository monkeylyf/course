User.destroy_all

# Donal Trump.
trump = User.create!(username: 'Trump', password_digest: 'password')
profile = Profile.create!(gender: 'male', birth_year: 1946, first_name: 'Donald', last_name: 'Trump', user: trump)
todo_list1 = TodoList.create!(list_name: 'trump\'s todo list', list_due_date: Date.today, user: trump)
TodoItem.create! [
  { due_date: Date.today, title: 'todo1', description: 'desc', todo_list: todo_list1 },
  { due_date: Date.today, title: 'todo2', description: 'desc', todo_list: todo_list1 },
  { due_date: Date.today, title: 'todo3', description: 'desc', todo_list: todo_list1 },
  { due_date: Date.today, title: 'todo4', description: 'desc', todo_list: todo_list1 },
  { due_date: Date.today, title: 'todo5', description: 'desc', todo_list: todo_list1 },
]

# Carly Fiorina.
fiorina = User.create!(username: 'Fiorina', password_digest: 'password')
profile = Profile.create!(gender: 'female', birth_year: 1954, first_name: 'Carly', last_name: 'Fiorina', user: fiorina)
todo_list2 = TodoList.create!(list_name: 'fiorina\'s todo list', list_due_date: Date.today, user: fiorina)
TodoItem.create! [
  { due_date: Date.today, title: 'todo6', description: 'desc', todo_list: todo_list2 },
  { due_date: Date.today, title: 'todo7', description: 'desc', todo_list: todo_list2 },
  { due_date: Date.today, title: 'todo8', description: 'desc', todo_list: todo_list2 },
  { due_date: Date.today, title: 'todo9', description: 'desc', todo_list: todo_list2 },
  { due_date: Date.today, title: 'todo10', description: 'desc', todo_list: todo_list2 },
]

# Ben Carson.
carson = User.create!(username: 'Carson', password_digest: 'password')
profile = Profile.create!(gender: 'male', birth_year: 1951, first_name: 'Ben', last_name: 'Carson', user: carson)
todo_list3 = TodoList.create!(list_name: 'carson\'s todo list', list_due_date: Date.today, user: carson)
TodoItem.create! [
  { due_date: Date.today, title: 'todo11', description: 'desc', todo_list: todo_list3 },
  { due_date: Date.today, title: 'todo12', description: 'desc', todo_list: todo_list3 },
  { due_date: Date.today, title: 'todo13', description: 'desc', todo_list: todo_list3 },
  { due_date: Date.today, title: 'todo14', description: 'desc', todo_list: todo_list3 },
  { due_date: Date.today, title: 'todo15', description: 'desc', todo_list: todo_list3 },
]

# Hillary Clinton.
clinton = User.create!(username: 'Clinton', password_digest: 'password')
profile = Profile.create!(gender: 'female', birth_year: 1947, first_name: 'Hillary', last_name: 'Clinton', user: clinton)
todo_list4 = TodoList.create!(list_name: 'clinton\'s todo list', list_due_date: Date.today, user: clinton)
TodoItem.create! [
  { due_date: Date.today, title: 'todo16', description: 'desc', todo_list: todo_list4 },
  { due_date: Date.today, title: 'todo17', description: 'desc', todo_list: todo_list4 },
  { due_date: Date.today, title: 'todo18', description: 'desc', todo_list: todo_list4 },
  { due_date: Date.today, title: 'todo19', description: 'desc', todo_list: todo_list4 },
  { due_date: Date.today, title: 'todo20', description: 'desc', todo_list: todo_list4 },
]
