/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("zopeijwbvmiq5a4")

  collection.indexes = [
    "CREATE UNIQUE INDEX `idx_Ft1FKm6` ON `residentes_de_obra` (\n  `nombres`,\n  `apellidos`\n)"
  ]

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("zopeijwbvmiq5a4")

  collection.indexes = []

  return dao.saveCollection(collection)
})
