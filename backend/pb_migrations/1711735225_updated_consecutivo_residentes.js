/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("4r04ttoziv5f09u")

  collection.name = "consecutivo_residentes_de_obra"

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("4r04ttoziv5f09u")

  collection.name = "consecutivo_residentes"

  return dao.saveCollection(collection)
})
