/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("tzh8rr90bve47xa")

  collection.name = "clientes"

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("tzh8rr90bve47xa")

  collection.name = "companies"

  return dao.saveCollection(collection)
})
