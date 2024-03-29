/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("pt5b8cz4jipz80y")

  collection.indexes = [
    "CREATE UNIQUE INDEX `idx_KyB9KZK` ON `obras` (`consecutivo`)"
  ]

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("pt5b8cz4jipz80y")

  collection.indexes = []

  return dao.saveCollection(collection)
})
