names =
  * id: 1
    name: \cca
  * id: 2
    name: \can
  * id: 3
    name: \me

ages =
  * id: 1
    age: 30
  * id: 2
    age: 21
  * id: 3
    age: 19

require! {
  \prelude-ls : {
    sort-by,
    reverse,
    reject,
    filter,
  }
}


get-view = ->
  [{n.id, n.name, a.age} for n in names for a in ages when n.id is a.id]

console.log ''
console.log 'first join: '
console.log '-'*30
console.log (get-view! |> sort-by (.age) |> reverse)

# update cca's age to 32 and name to 'cca2'
[(a.age = 32; n.name = \cca2) for a in ages for n in names when a.id is n.id and n.name is \cca]

console.log ''
console.log 'cca:30 is updated to cca2:32 : '
console.log '-'*30
console.log get-view!

# remove cca2 entry from tables
d = [n.id for n in names when n.name is \cca2].0

names = reject (.id is d), names
ages = reject (.id is d), ages

console.log ''
console.log 'cca2 is removed: '
console.log '-'*30
console.log get-view!


/* Output: 

first join: 
------------------------------
[ { id: 1, name: 'cca', age: 30 },
  { id: 2, name: 'can', age: 21 },
  { id: 3, name: 'me', age: 19 } ]

cca:30 is updated to cca2:32 : 
------------------------------
[ { id: 1, name: 'cca2', age: 32 },
  { id: 2, name: 'can', age: 21 },
  { id: 3, name: 'me', age: 19 } ]

cca2 is removed: 
------------------------------
[ { id: 2, name: 'can', age: 21 },
  { id: 3, name: 'me', age: 19 } ]

*/