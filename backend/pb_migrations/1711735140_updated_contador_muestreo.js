/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("ry2mslmjxy6sorn")

  collection.name = "consecutivo_muestreo"

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("ry2mslmjxy6sorn")

  collection.name = "contador_muestreo"

  return dao.saveCollection(collection)
})
