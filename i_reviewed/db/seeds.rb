Book.destroy_all


Book.create! [
  { name: "Eloquent Ruby", author: "Russ Olsen" },
  { name: "Beginning Ruby", author: "Peter Cooper" },
  { name: "Metaprogramming Ruby2", author: "Paulo Perrotta" },
  { name: "Design Patterns in  Ruby", author: "Russ Olsen" },
  { name: "The Ruby Programming Language", author: "David Flanagan" },
]

200.times { |index| Book.create! name: "Book Num.#{index}", author: "Author#{index}"}

eloqunent = Book.find_by name: "Eloquent Ruby"
eloqunent.notes.create! [
  { title: "mark", note: "what the fuck" },
  { title: "doh", note: "what the heck" },
]


Reviewer.destroy_all
reviewers = Reviewer.create! [
  { name: "yifeng", password: "admin" },
  { name: "admin", password: "admin" },
  { name: "chao", password: "admin" },
]

Book.all.each do |book|
  book.reviewer = reviewers.sample
  book.save!
end
