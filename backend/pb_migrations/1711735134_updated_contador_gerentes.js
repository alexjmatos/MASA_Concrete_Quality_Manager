/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("0fxrcsec20en773")

  collection.name = "consecutivo_gerentes"

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("0fxrcsec20en773")

  collection.name = "contador_gerentes"

  return dao.saveCollection(collection)
})
