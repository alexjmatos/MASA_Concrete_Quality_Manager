/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("4tsftbf5djxkj6s")

  collection.name = "consecutivo_direcciones"

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("4tsftbf5djxkj6s")

  collection.name = "contador_direcciones"

  return dao.saveCollection(collection)
})
