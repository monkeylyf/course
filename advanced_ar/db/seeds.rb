Person.destroy_all

Person.create! [
  { first_name: 'Yifeng', last_name: 'Liu', age: 29, login: 'yifeng', pass: 'abc123' },
  { first_name: 'Chao', last_name: 'Yang', age: 33, login: 'chao', pass: '123abc' },
  { first_name: 'Jisheng', last_name: 'Wang', age: 36, login: 'jisheng', pass: '123' },
  { first_name: 'Shirley', last_name: 'Wu', age: 43, login: 'shirley', pass: 'abc' },
]


Job.destroy_all
Person.first.jobs.create! [
  { title: 'MTS', company: 'Niara', positiion_id: '#21'},
  { title: 'Gamer', company: 'Indoosie', positiion_id: 'root'},
]

Person.last.jobs.create! [
  { title: 'MTS', company: 'Niara', positiion_id: '#15'}
]
