/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("pt5b8cz4jipz80y")

  collection.name = "obras"

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("pt5b8cz4jipz80y")

  collection.name = "project_sites"

  return dao.saveCollection(collection)
})
