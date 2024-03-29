/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("c8t6d6qgba6slko")

  collection.indexes = [
    "CREATE UNIQUE INDEX `idx_gzQBM0d` ON `gerentes` (`consecutivo`)"
  ]

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("c8t6d6qgba6slko")

  collection.indexes = []

  return dao.saveCollection(collection)
})
