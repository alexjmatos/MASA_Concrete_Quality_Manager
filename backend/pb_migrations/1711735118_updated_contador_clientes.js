/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("kq1m01a6gss4ftn")

  collection.name = "consecutivo_clientes"

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("kq1m01a6gss4ftn")

  collection.name = "contador_clientes"

  return dao.saveCollection(collection)
})
