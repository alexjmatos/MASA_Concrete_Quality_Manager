/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("4s6q4bwh0jofrbl")

  collection.indexes = [
    "CREATE UNIQUE INDEX `idx_WC0vKX9` ON `direcciones` (`consecutivo`)"
  ]

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("4s6q4bwh0jofrbl")

  collection.indexes = []

  return dao.saveCollection(collection)
})
