/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("kq1m01a6gss4ftn")

  collection.indexes = [
    "CREATE UNIQUE INDEX `idx_61kjA5g` ON `contador_clientes` (`contador`)"
  ]

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("kq1m01a6gss4ftn")

  collection.indexes = []

  return dao.saveCollection(collection)
})
