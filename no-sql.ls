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


joined = -> 
  [{n.id, n.name, a.age} for n in names for a in ages when n.id is a.id]

console.log ''
console.log 'first join: '
console.log '-'*30
console.log (joined! |> sort-by (.age) |> reverse)

# update cca's age to 32 and name to 'cca2'
[(a.age = 32; n.name = \cca2) for a in ages for n in names when a.id is n.id and n.name is \cca]

console.log ''
console.log 'cca is updated to cca2:32 : '
console.log '-'*30
console.log joined! 

# remove cca entry from tables
id-to-del = [n.id for n in names when n.name is \cca2].0

names = filter (.id isnt id-to-del), names 
ages = filter (.id isnt id-to-del), ages 

console.log ''
console.log 'cca2 is removed: '
console.log '-'*30
console.log joined!
