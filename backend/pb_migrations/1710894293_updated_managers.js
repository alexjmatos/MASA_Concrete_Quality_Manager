/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("zopeijwbvmiq5a4")

  collection.name = "residentes"

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("zopeijwbvmiq5a4")

  collection.name = "managers"

  return dao.saveCollection(collection)
})
