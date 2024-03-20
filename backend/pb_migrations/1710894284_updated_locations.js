/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("4s6q4bwh0jofrbl")

  collection.name = "direcciones"

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("4s6q4bwh0jofrbl")

  collection.name = "locations"

  return dao.saveCollection(collection)
})
