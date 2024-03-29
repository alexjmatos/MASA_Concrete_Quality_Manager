/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("4tsftbf5djxkj6s")

  // remove
  collection.schema.removeField("lkte5ghk")

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("4tsftbf5djxkj6s")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "lkte5ghk",
    "name": "direccion_id",
    "type": "relation",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "collectionId": "4s6q4bwh0jofrbl",
      "cascadeDelete": false,
      "minSelect": null,
      "maxSelect": 1,
      "displayFields": null
    }
  }))

  return dao.saveCollection(collection)
})
