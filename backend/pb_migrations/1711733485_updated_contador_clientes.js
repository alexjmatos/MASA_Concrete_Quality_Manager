/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("kq1m01a6gss4ftn")

  // update
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "fhzpkibq",
    "name": "activo",
    "type": "bool",
    "required": false,
    "presentable": true,
    "unique": false,
    "options": {}
  }))

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("kq1m01a6gss4ftn")

  // update
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "fhzpkibq",
    "name": "active",
    "type": "bool",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {}
  }))

  return dao.saveCollection(collection)
})
